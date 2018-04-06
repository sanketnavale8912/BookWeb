package com.drysign.utility;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;

public class TestElements {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		List<String> oldList=new ArrayList<>();
		oldList.add("1");
		
		List<String> newList=new ArrayList<>();
		newList.add("0");
		newList.add("1");
		newList.add("1");
		newList.add("1");
		
		
		LinkedHashSet<String> s = new LinkedHashSet<String>();
		s.addAll(newList);
		
		List<String> fList=new ArrayList<>();
		
		fList.addAll(s);
		boolean x=equalLists(oldList,fList);
		System.out.println(x);	
				
		
		
		/*newList.retainAll(oldList); // This will keep all elements that matches list 2 and remove other
		for(String word: newList)
		{
		System.out.println(word); //it will print all words in list 1
		}*/
	}
	
	public static boolean equalLists(List<String> one, List<String> two){     
	    if (one == null && two == null){
	        return true;
	    }

	    if((one == null && two != null) 
	      || one != null && two == null
	      || one.size() != two.size()){
	        return false;
	    }

	    //to avoid messing the order of the lists we will use a copy
	    //as noted in comments by A. R. S.
	    one = new ArrayList<String>(one); 
	    two = new ArrayList<String>(two);   

	    Collections.sort(one);
	    Collections.sort(two);      
	    return one.equals(two);
	}

}
