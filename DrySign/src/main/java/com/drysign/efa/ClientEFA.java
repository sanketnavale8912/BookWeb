package com.drysign.efa;
import java.io.BufferedReader;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Vector;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.log4j.Logger;
import org.omg.CORBA.SystemException;

import com.drysign.dao.DaoException;
import com.drysign.model.EFAConfigDetails;
import com.drysign.utility.*;
import corba.LoginFailedEx;
import corba.EFA.EFAException;
import corba.EFA.TooManyHitsEx;
import corba.EFA.ObjectDefinition;
import corba.EFA.ObjectPropertyW;
import corba.EFA.ObjectInstance;
import corba.EFA.SearchOperator;
import corba.EFA.SearchCriteriaW;
import corba.EFA.ObjectContent;
import corba.EFA.QuerySession;
import corba.EFA.QueryResult;
import corba.EFA.ImportSession;
import corba.EFA.IndexDef;
import corba.EFA.EFAErrorCode;
import corba.LoginController;
import corba.EFAServer;
import corba.EFAUtil;

@SuppressWarnings("serial")
class ClientEx extends Exception {
	String msg;

	public ClientEx(String msg) { this.msg = msg; }
	public String ErrorMsg() {return msg;}
};

public class ClientEFA {
	private static final Logger logger = Logger.getLogger(ClientEFA.class);
	String className = this.getClass().getSimpleName();
	private static String HOST,PORT,SERVER,USERNAME,PASSWORD,DOWNLOAD_FILE_PATH  = null;
	public ClientEFA() {
		// TODO Auto-generated constructor stub
		EFAConfigDetails cEFA = null;
		GlobalFunctions globalfunctions = new GlobalFunctions();
		try {
			cEFA = globalfunctions.getEFAdetails();
			HOST = cEFA.getHost();
			PORT=  cEFA.getPort();
			SERVER=cEFA.getServer();
			USERNAME=cEFA.getUsername();
			PASSWORD=cEFA.getPassword();
			DOWNLOAD_FILE_PATH=cEFA.getDownloadFilePath();
			} catch (UtilityException e) {
			e.printStackTrace();
		}
		
	}
	EFAUtil efautil;
	static BufferedReader cin;
	static PrintStream cout;
	LoginController efalogin;	// EFA login service
	EFAServer efaserver;		// EFA server, gives access to other services
	String objectName;

	/*
	 * This method connects to the efa login service using the corba naming 
	 * (CosNaming) service. The reference to the naming service must be 
	 * passed as an initial reference (see ORBacus documentation for details)
	 */
	public void ConnectToEFA(String args[])
		throws ClientEx, java.io.IOException
	{
		try {
			String host;
			String port;
			cout.print("Host name of Naming Service: ");
			host = cin.readLine();
			cout.print("Port number of Naming Service: ");
			port = cin.readLine();
			efautil = new EFAUtil(args, host, Integer.parseInt(port));
		}
		catch (org.omg.CORBA.UserException ex) {
			System.out.println(ex);
			throw new ClientEx("Could not find CORBA naming service");
		}
		catch (org.omg.CORBA.SystemException ex) {
			System.out.println(ex);
			throw new ClientEx("Could not find CORBA naming service");
		}
		try {
			String[] servers = efautil.getServerList();
			cout.print("EFA servers :");
			for (int i=0; i<servers.length; i++)
			{
				cout.print(" " + servers[i]);
			}
			cout.println("");
			String server;
			cout.print("Server: ");
			server = cin.readLine();
			efalogin = efautil.connectToEFA(server);
		}
		catch (org.omg.CORBA.UserException ex) {
			throw new ClientEx("Could not connect to eFIRST archive+");
		}
	}
	
	public void ConnectToEFA(String args[],String host,String port,String server)
			throws ClientEx, java.io.IOException
		{
			try {
				efautil = new EFAUtil(args, host, Integer.parseInt(port));
			}
			catch (org.omg.CORBA.UserException ex) {
				System.out.println(ex);
				throw new ClientEx("Could not find CORBA naming service");
			}
			catch (org.omg.CORBA.SystemException ex) {
				System.out.println(ex);
				throw new ClientEx("Could not find CORBA naming service");
			}
			try {
				efalogin = efautil.connectToEFA(server);
			}
			catch (org.omg.CORBA.UserException ex) {
				throw new ClientEx("Could not connect to eFIRST archive+");
			}
		}

	/*
	 * This method logs into EFA. LoginController returns a EFAServer 
	 * reference which gives access to the other services. 
	 */
	public void Login()
		throws ClientEx, java.io.IOException
	{
		String username;
		String password;
		cout.print("Username: ");
		username = cin.readLine();
		cout.print("Password: ");
		password = cin.readLine();
		try {
			efaserver = efalogin.Login(username, password);
		}
		catch (LoginFailedEx ex) {
			throw new ClientEx("Invalid username/password");
		}
		catch (EFAException ex) {
			throw new ClientEx(ex.ErrorMsg);
		}
		catch (SystemException e) {
			throw new ClientEx("Server is not running");
		}
	}

	/*
	 * This method logs into EFA. LoginController returns a EFAServer 
	 * reference which gives access to the other services. 
	 */
	public void Login(String username,String password)
		throws ClientEx, java.io.IOException
	{
		try {
			efaserver = efalogin.Login(username, password);
		}
		catch (LoginFailedEx ex) {
			throw new ClientEx("Invalid username/password");
		}
		catch (EFAException ex) {
			throw new ClientEx(ex.ErrorMsg);
		}
		catch (SystemException e) {
			throw new ClientEx("Server is not running");
		}
		
	}	

	/*
	 * This method querys the user for a object name and returns the 
	 * object definition for that object
	 */
	public ObjectDefinition GetObjectDefinition(String objectName)
		throws ClientEx, java.io.IOException
	{
		try {
			ObjectDefinition objdef = efaserver.GetObjectDefinition(objectName);
			return objdef;
		}
		catch (EFAException ex) {
			throw new ClientEx(ex.ErrorMsg);
		}
		catch (SystemException ex) {
			throw new ClientEx("GetObjectDefinition() failed: " + ex.getClass().getName());
		}
	}


	/* Store-related methods */
	/*
	 * This method stores a new object instance
	 */
	public String Store(ObjectDefinition objdef,String filePath,String objectName,String envelopeId,String refDocId)
		throws ClientEx, java.io.IOException
	{
		try {
			/*
			 * Let the user input index data
			 */

			ObjectPropertyW[] propList = GetProperties(objdef,objectName,envelopeId,refDocId);

			/*
			 * Get file names of images from the user
			 * and read the file contents
			 */
			byte[][] objData = ReadObjectContent(filePath);

			/*
			 * Create an import session on the server
			 */
			ImportSession importSession = efaserver.CreateImportSession(objectName);

			/*
			 * This is the call that actually stores the new instance of the object
			 * This method can be called repeatedly
			 */
			importSession.StoreInstanceW(propList, objData);

			/*
			 * Free the session after import is complete
			 */
			importSession.Release();

			logger.info("Stored item successfully");
			
			return "success";
		}
		catch (EFAException ex) {
			System.out.println("Error while Storing document item");
			throw new ClientEx(ex.ErrorMsg);
		}
		catch (SystemException ex) {
			throw new ClientEx("Store failed: " + ex.getClass().getName());
		}
	}


	/*
	 * This method prompts the user for each index field
	 */
	public ObjectPropertyW[] GetProperties(ObjectDefinition objdef,String objectName,String envelopeId,String refDocId)
		throws java.io.IOException, EFAException
	{
		/*
		 * The indexlist corresponds to the index list in the admin tool
		 */
		IndexDef[] indexList = objdef.GetIndexList();
		Vector propList = new Vector();
		String value = null;
		int propLen = 0;
		for (int i=0; i<indexList.length; i++) {

			/*
			 * We could be clever here and check the minRequired 
			 * and maxAllowed, but for now we'll just prompt the 
			 * user for one of each. 
			 */
			//System.out.print(indexList[i].name + ": ");
			if(objectName =="DocumentObject1" || objectName =="DocHistObject1"  || objectName =="SignatureObject1" || objectName =="ProfileObject1" || objectName =="FieldObject1"){
				
				if(i==0){
					logger.info(indexList[i].name + "---------> "+refDocId);
					value = refDocId;
				}
				if(i==1){
					logger.info(indexList[i].name + "---------> "+envelopeId);
					value = envelopeId;
				}
			}
			//value = cin.readLine();
			if (value.length() < 1) {
				break;
			}
			ObjectPropertyW prop = new ObjectPropertyW(indexList[i].name, value);
			propList.addElement(prop);
			propLen++;
		}
		ObjectPropertyW[] props = new ObjectPropertyW[propList.size()];
		for (int i=0; i<props.length; i++) {
			props[i] = (ObjectPropertyW) propList.elementAt(i);
		}
		return props;
	}


	/*
	 * This method prompts the user for a file name and 
	 * reads the file contents into an ObjPart
	 */
	public byte[][] ReadObjectContent(String filename)
		throws ClientEx, java.io.IOException
	{
		int partNum = 0;
		//String filename;
		Vector objData = new Vector();
		while (true)
		{
			logger.info("Filename of object part " + (partNum+1) + ": ");
			//filename = cin.readLine();
			if (filename.length() == 0) {
				break;
			}
			File file = new File(filename);
			FileInputStream ifile;
			try {
				ifile = new FileInputStream(file);
			}
			catch (java.io.FileNotFoundException ex) {
				throw new ClientEx("Cannot read file");
			}

			/*
			 * This is to get the file size
			 */
			int len = (int) file.length();

			byte[] objPart = new byte[len];

			ifile.read(objPart, 0, len);

			objData.addElement(objPart);
			partNum++;
			ifile.close();
			break;
		}
		byte[] data[] = new byte[objData.size()][];
		for (int i=0; i<data.length; i++) {
			data[i] = (byte[]) objData.elementAt(i);
		}
		return data;
	}


	/* Lookup-related methods */

	/*
	 * This method performes a search in EFA
	 */
	public String  Lookup(ObjectDefinition objdef,String downloadFilePath,String objectName,String envelopeId,String refDocId)
		throws ClientEx, java.io.IOException
	{
		String fileName=null;
		try {
			/* Query the user for the search criteria */

			SearchCriteriaW[] searchCriteria = GetSearchCriteria(objdef,envelopeId,refDocId,objectName);

			ObjectInstance[] instList;

			/*
			 * Create a query session for this object
			 */
			QuerySession querySession = efaserver.CreateObjectQuery(objectName);

			/*
			 * A query returns a result object, with the maximum number of 
			 * hits requested. If there are more hits than that, an EFAException 
			 * is thrown with ErrorCode=EFA.ERR_TOOMANYMATCHES
			 */
			QueryResult queryResult = querySession.LookupW(searchCriteria, 100);

			/*
			 * Free the query session object
			 */
			querySession.Release();

			/*
			 * You can call QueryResult.GetNextHit() to get the next hit, 
			 * or QueryResult.GetMoreHits(n) to get the next n hits. This 
			 * call can be called repeatedly
			 */
			instList = queryResult.GetMoreHits(100);
			queryResult.Release();

			/* Display the hit list to the user */

			logger.info("Found items");
			for (int i=0; i<instList.length; i++) {
				System.out.println(" " + (i+1));
			}
			logger.info("");
			/* Allow the user to browse items in the hit list */
			while (true)
			{
				int item = 0;
				logger.info("Show item (0 to quit): ");
				item = Integer.parseInt("1");
				if (item == 0) {
					break;
				}
				if (item > instList.length) {
					logger.info("Not in result list");
					break;
				}
				ShowProperties(instList[item-1].GetPropertiesW());

				/* Allow the user to save the archived content */
				String s="Y";
				 //Y OR N
				if (s.equals("Y")) {
					fileName=WriteObjectContent(instList[item-1].GetObjectContent(),downloadFilePath,refDocId);
				}
				
				break;
			}
		}
		catch (TooManyHitsEx ex) {
			logger.info("Too many matches!  There were ");
			logger.info(ex.totalHits);
			logger.info(" total");
		}

		catch (EFAException ex) {
			if (ex.ErrorCode == EFAErrorCode.ERR_TOOMANYMATCHES) {
				// Do whatever
			}
			throw new ClientEx(ex.ErrorMsg);
		}
		catch (SystemException ex) {
			throw new ClientEx("Lookup() failed: " + ex.getClass().getName());
		}
		return fileName;

	}

	/*
	 * This method displays each property name-value pair to the user
	 */
	public void ShowProperties(ObjectPropertyW[] propList)
	{
		for (int i=0; i<propList.length; i++) {
			logger.info(propList[i].name + ": " + propList[i].value);
		}
	}


	/*
	 * This method prompts the user for each index field
	 */
	public SearchCriteriaW[] GetSearchCriteria(ObjectDefinition objdef,String envelopeId,String refDocId,String objectName)
		throws java.io.IOException, EFAException
	{
		/*
		 * The indexlist corresponds to the index list in the admin tool
		 */
		IndexDef[] indexList = objdef.GetIndexList();
		Vector propList = new Vector();
		String value = null;
		int propLen = 0;
		for (int i=0; i<indexList.length; i++) {

			/*
			 * If we try to search on non-searchable fields, 
			 * we'll only get an exception back, so don't 
			 * we wont even try that. 
			 */
			if (!indexList[i].searchable) {
				continue;
			}

			/*
			 * We could be clever here and check the minRequired 
			 * and maxAllowed, but for now we'll just prompt the 
			 * user for one of each. 
			 */
			
			if(objectName =="DocumentObject1" || objectName =="DocHistObject1" || objectName =="SignatureObject1" || objectName =="ProfileObject1" || objectName =="FieldObject1"){
				logger.info(indexList[i].name + ": ");
				if(i==0){
					value = refDocId;
				}
				if(i==1){
					value = envelopeId;
				}
			}
			
			if (value.length() < 1) {
				continue;
			}
			SearchCriteriaW prop = new SearchCriteriaW();
			prop.name = indexList[i].name;
			switch (value.charAt(0)) {
			case '<':
				prop.operation = SearchOperator.LESS_THAN;
				prop.value = value.substring(1);
				break;
			case '>':
				prop.operation = SearchOperator.GREATER_THAN;
				prop.value = value.substring(1);
				break;
			case '!':
				prop.operation = SearchOperator.NOT_EQUALS;
				prop.value = value.substring(1);
				break;
			default:
				prop.operation = SearchOperator.EQUALS;
				prop.value = value;
			}
			propList.addElement(prop);
			propLen++;
		}
		SearchCriteriaW[] props = new SearchCriteriaW[propList.size()];
		for (int i=0; i<props.length; i++) {
			props[i] = (SearchCriteriaW) propList.elementAt(i);
		}
		return props;
	}


	/*
	 * This method gets all object parts from the archive and writes 
	 * each part in a separate file. 
	 */
	String WriteObjectContent(ObjectContent objectContent,String downloadFilePath,String refDocId)
		throws ClientEx, java.io.IOException
	{
		String osfilename = null,tempFile=null;
		try {
			byte[][] objData = objectContent.GetParts();
			for (int i=0; i<objData.length; i++) {
			tempFile =downloadFilePath;
			Path path = Paths.get(tempFile);
		        //if directory exists?
	        if (!Files.exists(path)) {
	            try {
	                Files.createDirectories(path);
	            } catch (IOException e) {
	                //fail to create directory
	                e.printStackTrace();
	            }
	        }

			
	        osfilename = RandomStringUtils.randomAlphabetic(10) + ".pdf";
			File file = new File(osfilename);
			FileOutputStream ofile = new FileOutputStream(tempFile+"/"+file);
			ofile.write(objData[i], 0, objData[i].length);
			logger.info("Wrote " + osfilename);
			ofile.close();
			}
		}
		catch (EFAException ex) {
			throw new ClientEx(ex.ErrorMsg);
		}
		catch (SystemException ex) {
			throw new ClientEx("ObjectContent.GetParts() failed");
		}
		return tempFile+osfilename;
	}

	public static void main(String args[]){
		ClientEFA c = new ClientEFA();
		String filePath="D:/agreement.pdf";
		
		/****DocumentObject 	**********/
		
		try {
			String s=c.efaLookUp(c, "DocumentObject1", "6a57f86b-c809-4888-a9a8-0d4e1f27ee11", "x58BrCcDQR");
			//String s=c.efaStore(c, "DocumentObject1", "46aec261-7707-498b-bc3333fd-a4fee185d6ce23", "nAaFyTgFtD2312",filePath);
			System.out.println("Status:"+s);
		} catch (DaoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println(c);
		//System.out.println(s);
		
		/****DocHistObject 
		c.efaStore(c, "DocHistObject", "57557730-4792-47be-a447-eeb6ead09a7XF", "57557736",filePath);
		c.efaLookUp(c, "DocHistObject", "57557730-4792-47be-a447-eeb6ead09a7R", "57557732");
		**********/
		
		/****SignatureObject 
		c.efaStore(c, "SignatureObject",null, "57557738",filePath);
		c.efaLookUp(c, "SignatureObject", null, "57557738");
		**********/
		
		/****ProfileObject 	
		//UserId,RefPhotoId
		c.efaStore(c, "ProfileObject","101", "102",filePath);
		c.efaLookUp(c, "ProfileObject","101", "102");
		 **********/
		
		/****FieldObject	
		//RefFieldID,FieldID
		c.efaStore(c, "FieldObject","104", "103",filePath);
		c.efaLookUp(c, "ProfileObject","101", "102");
		***/ 
		System.exit(0);
	}
	
	public String efaStore(ClientEFA c,String objectName,String envelopedId,String refDocId,String FILE_PATH)throws DaoException{
		String classMethod = "efaStore";
		String status=null;
		logger.info(String.format("Enter into " + classMethod + "()"));
		ObjectDefinition objdef;
			try {
			c.ConnectToEFA(null, HOST, PORT, SERVER);
			
			c.Login(USERNAME, PASSWORD);
			objdef = c.GetObjectDefinition(objectName);
			status = c.Store(objdef, FILE_PATH, objectName, envelopedId,refDocId);
			} catch (ClientEx e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				status=e.msg;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				status=e.getMessage();
			}
		
		logger.info(String.format("Exit into " + classMethod + "()"));
		return status;
	}
	
	public String efaLookUp(ClientEFA c,String objectName,String envelopedId,String refDocId)throws DaoException{
		String classMethod = "efaLookUp";
               		logger.info(String.format("Enter into " + classMethod + "()"));
		String fileName=null;
		ObjectDefinition objdef;
		try {
			c.ConnectToEFA(null, HOST, PORT, SERVER);
			c.Login(USERNAME, PASSWORD);
			objdef = c.GetObjectDefinition(objectName);
			fileName= c.Lookup(objdef, DOWNLOAD_FILE_PATH, objectName, envelopedId,refDocId);
		} catch (ClientEx e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		logger.info(String.format("Exit into " + classMethod + "()"));
		return fileName;
	}
};

