// Copyright (C) 1999 by BancTec AB.  All rights reserved.

package com.drysign.efa;

// Services import
import java.util.Properties;
import org.omg.CosNaming.*;
import corba.LoginController;
import corba.LoginControllerHelper;

/**
 * Class used to communicate with the Corba services.
 *
 * @author <b>Morten Knudsen</b>
 * @version 0.1, 06.12.1999
 */
public class EFAUtil {
    /**
     * Reference to orb and services
     */
    private org.omg.CORBA.ORB orb = null;
    private NamingContext rootContext = null;


	protected static volatile Properties orbProps = null;
  protected static Object lock = new Object();
    
	public EFAUtil(String[] args)
		throws org.omg.CORBA.ORBPackage.InvalidName
	{
		initOrb(args);
		rootContext = NamingContextHelper.narrow(orb.resolve_initial_references("NameService"));
	}

	public EFAUtil(String[] args, String host, int port)
		throws org.omg.CORBA.ORBPackage.InvalidName
	{
		initOrb(args);
		setNamingService(host, port);
	}
	
	protected void initOrb(String[] args){
    	
    	if(System.getProperties().containsKey("org.omg.CORBA.ORBClass") && System.getProperties().containsKey("org.omg.CORBA.ORBSingletonClass")){
			this.orb = org.omg.CORBA.ORB.init(args, null);
		}
		else if(orbProps != null){
			this.orb = org.omg.CORBA.ORB.init(args, orbProps);
		}
		else{ //probs all supported orbs: Orbacus and JacOrb
			synchronized(lock) {
				Properties[] propsArray = new Properties[2];
				propsArray[0] = new Properties();
				propsArray[0].put("org.omg.CORBA.ORBClass", "com.ooc.CORBA.ORB");
				propsArray[0].put("org.omg.CORBA.ORBSingeltonClass", "com.ooc.CORBA.ORBSingelton");
				propsArray[1] = new Properties();
				propsArray[1].put("org.omg.CORBA.ORBClass", "org.jacorb.orb.ORB");
				propsArray[1].put("org.omg.CORBA.ORBSingletonClass", "org.jacorb.orb.ORBSingleton");
				
				
				for(Properties props : propsArray){
					try{
						this.orb = org.omg.CORBA.ORB.init(args, props);
					}
					catch(org.omg.CORBA.INITIALIZE ex){
						if(props == propsArray[propsArray.length - 1]){
							throw ex;
						}
						else{
							continue;
						}
					}
					orbProps = props;
					break;
				}
			}
		}
  }

	protected void finalize()
		throws Throwable
	{
		orb.destroy();
	}

	public org.omg.CORBA.ORB getORB()
	{
		return orb;
	}

	public org.omg.CORBA.Object resolve(String[] path)
		throws 
			org.omg.CosNaming.NamingContextPackage.NotFound,
			org.omg.CosNaming.NamingContextPackage.CannotProceed,
			org.omg.CosNaming.NamingContextPackage.InvalidName
	{
		NameComponent name[] = new NameComponent[path.length];
		for (int i=0; i<path.length; i++)
		{
			name[i] = new NameComponent(path[i],"");
		}
		return rootContext.resolve(name);
	}

	public void setNamingService(String host, int port)
	{
		String ref = "corbaloc::" + host + ":" + port + "/NameService";
		rootContext = NamingContextHelper.narrow(orb.string_to_object(ref));
	}

	public String[] listContext(NamingContext nc)
	{
		BindingIteratorHolder bindingIterator = new BindingIteratorHolder();
		BindingListHolder bindingList = new BindingListHolder();
		
		nc.list(100, bindingList, bindingIterator); //get first 100...
		
		int total = 0;    

		String[] bl_list = new String[bindingList.value.length]; // transfer from list
		for (int i=0; i<bindingList.value.length; i++)
		{
			bl_list[i] = bindingList.value[i].binding_name[0].id;
		}
		total += bl_list.length;

		String[] it_list = new String[0]; 
		if (bindingIterator.value != null) // transfer from iterator (100 more (max))
		{
			BindingListHolder it_bindingList = new BindingListHolder();
			bindingIterator.value.next_n(100, it_bindingList);
			
			it_list = new String[it_bindingList.value.length];
			for (int z=0; z<it_bindingList.value.length; z++)
			{
				it_list[z] = it_bindingList.value[z].binding_name[0].id;
			}
		}
		total += it_list.length;

		// list used for return...
		String[] list = new String[total];

		// copy bindings obtained from list...
		for (int x=0; x<bl_list.length; x++)
		{
			list[x] = bl_list[x];
		}
		// copy bindings obtained from iterator...(append)
		for (int y=0; y<it_list.length; y++)
		{
			list[bl_list.length + y] = it_list[y];
		}
        
		// return all bindings
		return list;
	}

	public String[] listContext(String[] path)
		throws
			org.omg.CosNaming.NamingContextPackage.NotFound,
			org.omg.CosNaming.NamingContextPackage.CannotProceed,
			org.omg.CosNaming.NamingContextPackage.InvalidName
	{
		NamingContext nc = NamingContextHelper.narrow(resolve(path));
		return listContext(nc);
	}

	public String[] getServerList()
		throws
			org.omg.CosNaming.NamingContextPackage.NotFound,
			org.omg.CosNaming.NamingContextPackage.CannotProceed,
			org.omg.CosNaming.NamingContextPackage.InvalidName
	{
		String[] path = {"BancTec","EFA"};
		return listContext(path);
	}

	public LoginController connectToEFA(String server)
		throws
			org.omg.CosNaming.NamingContextPackage.NotFound,
			org.omg.CosNaming.NamingContextPackage.CannotProceed,
			org.omg.CosNaming.NamingContextPackage.InvalidName
	{
		String[] path = {"BancTec","EFA",server,"EFALogin"};
		return LoginControllerHelper.narrow(resolve(path));
	}
}



