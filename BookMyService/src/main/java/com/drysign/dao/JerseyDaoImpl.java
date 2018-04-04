package com.drysign.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.drysign.controller.JerseyFileUpload;
import com.drysign.model.ApplicationDocument;
import com.drysign.model.Audit;
import com.drysign.model.BackgroundSignDocument;
import com.drysign.model.BackgroundSignFields;
import com.drysign.model.ClientAuth;
import com.drysign.model.ClientUser;
import com.drysign.model.CreateSignatureRequest;
import com.drysign.model.DocumentField;
import com.drysign.model.DocumentSigner;
import com.drysign.model.DocumentWrapper;
import com.drysign.model.Download;
import com.drysign.model.Registration;
import com.drysign.model.RestDocument;
import com.drysign.model.RestDocumentField;
import com.drysign.model.SB_Purchase;
import com.drysign.model.SB_Subscription;
import com.drysign.model.VerifyDetails;
import com.drysign.utility.CommonUtils;
import com.drysign.utility.DateManipulation;
import com.drysign.utility.GlobalFunctions;

@Repository("jerseyDao")
@Transactional
public class JerseyDaoImpl implements JerseyDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	String className = this.getClass().getSimpleName();
	

	@Autowired
	private Properties queryProps;
	
	@Autowired
	private DataSource dataSource;
	
	
	private final static Logger logger = Logger.getLogger(JerseyDaoImpl.class);
/*	public JdbcTemplate getJdbcTemplate() {
	    return jdbcTemplate;
	}
	
	@Autowired
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
	    this.jdbcTemplate = jdbcTemplate;
	}*/
	
	public String addUserJersey(ClientUser clientUser) throws DaoException
	{
		logger.info(String.format("addUserJersey(ClientUser = %s)", clientUser));
		String sql = queryProps.getProperty("getStatusUserJersey");
		String msg;
		
		try{
		    List<Integer> status = jdbcTemplate.queryForList(sql, Integer.class,  clientUser.getClient().getClientId(), clientUser.getClient().getClientEmail(), clientUser.getClient().getClientPassword()); 
		    if (status.isEmpty()) {
		        msg = "Client Authenticaton Invalid.";
		        logger.error(msg);
		    } 
		    else if(status.get(0) == 1 ) 
		    {
		    	
		    	List<Integer> ids = jdbcTemplate.queryForList(queryProps.getProperty("getIdUserJersey"), Integer.class,clientUser.getEmail());
		    	
		    	if(ids.isEmpty()){
		    		jdbcTemplate.update(queryProps.getProperty("addUserJersey"),clientUser.getClient().getClientId(),clientUser.getEmail(),clientUser.getPassword(),"token",1,new DateManipulation().getMyDate());
		    		msg =  "User added successfully.";
		    	}
		    	else
		    	{
		    		msg =  "User already exist.";
		    	}
		    
		    }
		    else{
		    	msg = "Client not verified, Please verify your account";
		    }
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
		
		return msg;
	}

	public List<ClientUser> getAllClientUserDao(ClientAuth clientAuth) throws DaoException
	{
		logger.error(String.format("clientAuth = %s", clientAuth));
		String sql = queryProps.getProperty("getAllClientUser");
		String msg;
		List<ClientUser> clientUser = null;
		try{
		    List<Integer> status = jdbcTemplate.queryForList(sql, Integer.class,  clientAuth.getClientId(), clientAuth.getClientEmail(), clientAuth.getClientPassword()); 
		    if (status.isEmpty()) {
		        msg = "Client Authenticaton Invalid.";
		    }else{
		    	
		    	clientUser = jdbcTemplate.query("select * from tb_client_user where client_id = "+clientAuth.getClientId(),new RowMapper<ClientUser>(){  
					public ClientUser mapRow(ResultSet rs, int count)throws SQLException {
						ClientUser clientUser = new ClientUser();
						clientUser.setId(rs.getInt(1));
						clientUser.setEmail(rs.getString(3));
						clientUser.setPassword(rs.getString(4));
						clientUser.setToken(rs.getString(5));
						clientUser.setStatus(rs.getInt(6));
						clientUser.setDateTime(rs.getDate(7));
						
					
						return clientUser;
					}  
		    	    }); 
		    	
		    	
		    }
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
			return clientUser;
	}

	public String addDocumentDao(DocumentWrapper documentWrapper) throws DaoException
	{ 
		logger.info(String.format("documentWrapper = %s", documentWrapper));
		
		
		String sql = queryProps.getProperty("getStatusDocumentWebservice");
		String msg=null;
		String uniqueID = new GlobalFunctions().uniqueToken();
		
		try{
		List<Integer> status = jdbcTemplate.queryForList(sql, Integer.class, documentWrapper.getClientAuth().getClientId(),documentWrapper.getClientAuth().getClientEmail(),documentWrapper.getClientAuth().getClientPassword() ); 
	    if (status.isEmpty()) 
	    {
	        msg = "Client Authenticaton Invalid.";
	    }
	    else
	    {
	    	
	    	List<Integer> ids = jdbcTemplate.queryForList(queryProps.getProperty("getIdDocumentWebservice"), Integer.class,documentWrapper.getSigningDetails().getOriginatorId(),documentWrapper.getSigningDetails().getSignerId(), documentWrapper.getClientAuth().getClientId());
	    	
	    	if(!ids.isEmpty())
	    	{
	    		 long documentId = this.saveDocument(documentWrapper);
	    		if(documentId != 0)
	    		{
	    			for(DocumentField df : documentWrapper.getDocument().getDocumentFields())
		    		 {
		    			 jdbcTemplate.update(queryProps.getProperty("insertDocumentFieldsWebservice"),documentId,df.getFieldType(),df.getPageNumber(),df.getxPosition(),df.getyPosition(),df.getFieldHeight(),df.getFieldWidth(),df.getFieldName());
		    		 }
		    		 
		    		 jdbcTemplate.update(queryProps.getProperty("insertDocumentSignWebservice"),documentWrapper.getClientAuth().getClientId(),documentWrapper.getSigningDetails().getOriginatorId(),documentWrapper.getSigningDetails().getSignerId(),documentId,documentWrapper.getSigningDetails().getSigningOrder(),uniqueID,0,new DateManipulation().getMyDate(),new DateManipulation().getMyDate());
		    		
		    		msg =  "1";
	    		}else{
	    			msg =  "Problem in document id generation.";
	    		}
	    		 
	    	}
	    	else
	    	{
	    		msg =  "Originator or Signer may not exist.";
	    	}
	    }
		}catch(Exception e){
			throw new DaoException(e);
		}
		return msg;
	}
	
	

	public long saveDocument(final DocumentWrapper documentWrapper) throws DaoException
	{
		logger.info(String.format("saveDocument(documentWrapper = %s )", documentWrapper));
		KeyHolder keyHolder = new GeneratedKeyHolder();
		final String query_doc = queryProps.getProperty("saveDocumentWebservice");

		try{
		jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
	    	            PreparedStatement pst =con.prepareStatement(query_doc, new String[] {"id"});
	    	            int index = 1;
	                    pst.setLong(index++,documentWrapper.getSigningDetails().getClientId());
	                    pst.setLong(index++,documentWrapper.getSigningDetails().getOriginatorId());
	                    pst.setString(index++, documentWrapper.getDocument().getDocumentName());
	                    pst.setString(index++, documentWrapper.getDocument().getDocumentOriginalName());
	                    pst.setLong(index++, 1);
	                    pst.setTimestamp(index++, new DateManipulation().getMyDate());
	                    pst.setTimestamp(index++, new DateManipulation().getMyDate());
	                    return pst;
	    	        }
	    	    },
	    	    keyHolder);
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
		return (Long) keyHolder.getKey();
	
	}

	public ClientUser getClientUserDao(int originatorId) throws DaoException
	{
		  logger.info(String.format("getClientUserDao(originatorId = %s)", originatorId));
		    
		  String sql = queryProps.getProperty("getClientUserWebservice");
		  ClientUser clientUser;
		  
		  try{
			clientUser = jdbcTemplate.query(sql, new Object[] { originatorId }, new ResultSetExtractor<ClientUser>()
		    {
				public ClientUser extractData(ResultSet rs) throws SQLException,DataAccessException 
				{				
					if(rs.next()){
						ClientUser cu = new ClientUser();
						cu.setId(rs.getInt(1));
						cu.setEmail(rs.getString(3));
						cu.setPassword(rs.getString(4));
						cu.setToken(rs.getString(5));
						cu.setStatus(rs.getInt(6));
						cu.setDateTime(rs.getDate(7));
						return cu;
			    		}
					return null;				
				}
			});
		  }catch(Exception e){
			  throw new DaoException(e.getMessage());
		  }
			return (ClientUser) clientUser;
		
	}	
	
	

	@Override
	public List<DocumentField> getFieldData(String documentName) throws DaoException
	{
		logger.info(String.format("getFieldData(documentName=%s)", documentName));
		
		String query_partyId = queryProps.getProperty("getFieldDataWebservice");
		     
		List<DocumentField> dfList = new ArrayList<DocumentField>();
		try{ 
        List<Map<String,Object>> dfRows = jdbcTemplate.queryForList(query_partyId,new Object[]{documentName});
         
        for(Map<String,Object> df : dfRows){
        	DocumentField fields = new DocumentField();
        	
        	fields.setId((Integer.parseInt((String.valueOf(df.get("id"))))));
        	fields.setFieldName(String.valueOf(df.get("form_field_name")));
        	fields.setFieldType(String.valueOf(df.get("form_field_type")));
        	fields.setPageNumber(Integer.parseInt((String.valueOf(df.get("pageno")))));
        	fields.setFieldWidth(Float.parseFloat((String.valueOf(df.get("width")))));
        	fields.setFieldHeight(Float.parseFloat((String.valueOf(df.get("height")))));
        	fields.setxPosition(Float.parseFloat((String.valueOf(df.get("x_position")))));
        	fields.setyPosition(Float.parseFloat((String.valueOf(df.get("y_position")))));
        	dfList.add(fields);
        }
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
        return dfList;
	}

	@Override
	public int[] saveDocumentFields(final List<DocumentField> documentField) throws DaoException
	{
		logger.info(String.format("saveDocumentFields(documentField = %s )", documentField));
		int[] updateCnt;
		try{
		updateCnt = jdbcTemplate.batchUpdate(
				queryProps.getProperty("saveDocumentFieldsWebservice"),
                new BatchPreparedStatementSetter() {
                    public void setValues(PreparedStatement ps, int i) throws SQLException {
                    	ps.setString(1,documentField.get(i).getFieldValue());
                        ps.setInt(2,documentField.get(i).getId());
                    }
                    public int getBatchSize() {
                        return documentField.size();
                    }
                });
		
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
		
		return updateCnt;
		
	}

	@Override
    public VerifyDetails updateDocument(final String documentName) throws DaoException
	{
		

		logger.info(String.format("saveDocument(fname = %s)", documentName));

		List<Integer> ids = null;
		String sql = queryProps.getProperty("updateDocumentIdWebservice");
		String sqlOfverifyDetails = queryProps.getProperty("updateDocumentAllWebservice");
		VerifyDetails verifyDetails = null;
		try{
		     ids = jdbcTemplate.queryForList(sql, Integer.class, documentName,0);
		
		    if (!ids.isEmpty()) 
		    {
		    	jdbcTemplate.update(queryProps.getProperty("updateDocumentSignWebservice"), ids.get(0));
		    	
		    	
		    	 verifyDetails = jdbcTemplate.query(sqlOfverifyDetails, new Object[] { ids.get(0) }, new ResultSetExtractor<VerifyDetails>()
				    {
						public VerifyDetails extractData(ResultSet rs) throws SQLException,DataAccessException 
						{				
							if(rs.next()){
								VerifyDetails cu = new VerifyDetails();
								cu.setId(rs.getInt(1));
								cu.setFileName(rs.getString(2));
								cu.setOriginator(rs.getString(3));
								cu.setSigner(rs.getString(4));
								cu.setToken(rs.getString(5));
								return cu;
					    		}
							return null;				
						}
					});
				 
		    	
		    }
		    
		}catch(Exception e){
			logger.error(e.getMessage());
			throw new DaoException(e.getMessage());
		} 
		    
		return verifyDetails;
			

	}

	@Override
	public boolean readValidFileFromOriginator(int id, String token,String fname, String semail, String oemail) throws DaoException
	{
		logger.info(String.format("readValidFileFromOriginator(id = %s, token = %s, fname=%s, semail = %s, oemail = %s)", id,token,fname,semail,oemail));
		boolean flag = false;
		String sql = queryProps.getProperty("readValidFileFromOriginator");
		List<Integer> ids = null;
		try{
		ids = jdbcTemplate.queryForList(sql, Integer.class, fname,oemail,semail,token,1);
		if(ids.get(0) != null && ids.get(0).equals(id))
		{
			flag = true;
		}
		}catch(Exception e){
			flag = false;
			throw new DaoException(e.getMessage());
		}
		return flag;
	}

	@Override
	public ApplicationDocument getDcoument(String documentId) throws DaoException 
	{
		String classMethod = className+ ":  getDcoument" ;
		logger.info(String.format("Enter into "+classMethod+"(envelopeid= %s)", documentId));
		String sql = queryProps.getProperty("getDcoumentByEnvelopeId");
		
		try{
		    		ApplicationDocument document = jdbcTemplate.query(sql, new Object[] { documentId, }, new ResultSetExtractor<ApplicationDocument>()
		    	    {
		    			public ApplicationDocument extractData(ResultSet rs) throws SQLException,DataAccessException 
		    			{				
		    				if(rs.next())
		    				{
		    					ApplicationDocument doc = new ApplicationDocument();
		    					doc.setId(rs.getInt("id"));
		    		    		doc.setUserId(rs.getInt("user_id"));
		    		    		doc.setFileName(rs.getString("name"));
		    		    		doc.setEnvelopeId(rs.getString("envelopeid"));
		    		    		doc.setOriginalId(rs.getString("original_doc_id"));
		    		    		doc.setElectronicId(rs.getString("electronic_doc_id"));
		    		    		doc.setDigitalld(rs.getString("digital_doc_id"));
		    					doc.setOriginal(rs.getBlob("original") ==null ? null : rs.getBlob("original").getBinaryStream());
		    		    		doc.setDigital(rs.getBlob("digital") == null ? null : rs.getBlob("digital").getBinaryStream());
		    		    		return doc;
		    		    	}
		    				return null;				
		    			}
		    		});
		    		logger.info("exit from "+classMethod);
		    		return document;
		    		
		 }catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public ApplicationDocument getDcoument(Download download) throws DaoException 
	{
		String classMethod = className+ ":  getDcoument" ;
		logger.info(String.format("Enter into "+classMethod+"(download= %s)", download));
		String sql = queryProps.getProperty("getDcoumentWebservice");
		
		try{
		    		ApplicationDocument document = jdbcTemplate.query(sql, new Object[] { download.getEnvelopeId(),download.getFileName() }, new ResultSetExtractor<ApplicationDocument>()
		    	    {
		    			public ApplicationDocument extractData(ResultSet rs) throws SQLException,DataAccessException 
		    			{				
		    				if(rs.next())
		    				{
		    					ApplicationDocument doc = new ApplicationDocument();
		    					doc.setId(rs.getInt("id"));
		    		    		doc.setUserId(rs.getInt("user_id"));
		    		    		doc.setFileName(rs.getString("name"));
		    		    		doc.setEnvelopeId(rs.getString("envelopeid"));
		    		    		doc.setOriginalId(rs.getString("original_doc_id"));
		    		    		doc.setElectronicId(rs.getString("electronic_doc_id"));
		    		    		doc.setDigitalld(rs.getString("digital_doc_id"));
		    					doc.setOriginal(rs.getBlob("original") ==null ? null : rs.getBlob("original").getBinaryStream());
		    		    		doc.setDigital(rs.getBlob("digital") == null ? null : rs.getBlob("digital").getBinaryStream());
		    		    		return doc;
		    		    	}
		    				return null;				
		    			}
		    		});
		    		logger.info("exit from "+classMethod);
		    		return document;
		    		
		 }catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
	}
	
	@Override
	public int createDocument(final int userId, final String envelopeId,  final String fileName,final InputStream inputStream, final int status, final String signType, final String subject, final String message, final String clientIPAddress) throws DaoException 
	{
		String classMethod = className+ ":  createDocument" ;
		logger.info(String.format("Enter into "+classMethod+"(userId = %s,envelopeId = %s, fileName= %s, inputStream = %s, status = %s, signType = %s, subject = %s, message = %s, clientIPAddress = %s)", userId,envelopeId, fileName, inputStream, status, signType, subject, message, clientIPAddress));
		
		int flag = 0;
		
		KeyHolder keyHolder = new GeneratedKeyHolder();
		try{
		final int length = inputStream.available();
		final String sql = queryProps.getProperty("createDocumentWebservice");
		
		
			jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
	            PreparedStatement pst =con.prepareStatement(sql, new String[] {"id"});
	            int index = 1;
	            pst.setInt(index++,userId);
	            pst.setString(index++, envelopeId);
	            pst.setString(index++,fileName);
	            pst.setBinaryStream(index++,inputStream,length );
	            pst.setInt(index++, status);
	            pst.setString(index++, signType);
	            pst.setString(index++, subject);
	            pst.setString(index++, message);
	            pst.setString(index++, signType);
	            pst.setTimestamp(index++, CommonUtils.currentDate());
	            pst.setString(index++, clientIPAddress);
	            return pst;
	        }
	    },
	    keyHolder);
		
		logger.info("exit from "+classMethod);
		flag =  keyHolder.getKey().intValue();
	
		
		/*String sql1 = "update document set digital = ? where id = ? ";
		int status1 = jdbcTemplate.update(sql1, inputStream, flag);*/
		
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
		
		
		
		
		
		
		
		
		/*try{
			
		final String sql = "INSERT INTO document(user_id,envelopeid,name,original,electronic,digital,status,file_type,sign_type) VALUES(?,?,?,?,?,?,?,?,?)";
		
		flag = jdbcTemplate.update(sql,new Object[]{userId, envelopeId, fileName, inputStream,inputStream,inputStream, status, signType, signType});
	
				
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}*/
		return flag;
		
		
		
	}

	@Override
	public Registration getUser(String userName) throws DaoException 
	{
		String classMethod = className+ ":  getUser" ;
		logger.info(String.format("Enter into "+classMethod+"(userName = %s)", userName));	    
		String sql = queryProps.getProperty("getUserAllDetails");
	    
		try{
	    Registration user = jdbcTemplate.query(sql, new Object[] { userName }, new ResultSetExtractor<Registration>()
	    {
			public Registration extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				Registration r = new Registration();
				if(rs.next()){
		    		r.setId(rs.getInt("id"));
		    		r.setFirstName(rs.getString("firstname"));
		    		r.setLastname(rs.getString("lastname"));
		    		r.setPhoto(rs.getString("photo"));
		    		r.setEmail(rs.getString("email"));
		    		r.setPhone(rs.getString("phone"));
		    		r.setCountry(rs.getString("country"));
		    		r.setState(rs.getString("state"));
		    		r.setPincode(rs.getString("pincode"));
		    		r.setPassword(rs.getString("password"));
		    		r.setCompanyName(rs.getString("company_name"));
		    		r.setJobTitle(rs.getString("job_title"));
		    		r.setClientId(rs.getString("client_id"));
		    		r.setClientSecret(rs.getString("client_secret"));
		    		r.setEmail_verification_token(rs.getString("email_verification_token"));
		    		r.setUser_type(rs.getInt("user_type"));
		    		
		    		r.setStatus(rs.getInt("status"));
		    		r.setRole(rs.getString("role"));
		    		r.setIsCompany(rs.getString("is_company"));
		    		r.setDate(rs.getDate("created_on"));
		    		r.setUpdatedOn(rs.getDate("updated_on"));
		    		r.setProject(rs.getString("project_name"));
		    		r.setTheme(rs.getString("theme"));
		    		r.setLinktodrysign(rs.getString("drysignlink"));
		    		r.setDeviceVersion(rs.getString("deviceversion"));
		    		return r;
		    		}
				return r;				
			}
		});	
	    logger.info("exit from "+classMethod);
		return (Registration) user;
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
	}

	
	@Override
	public int modifyDocument(final RestDocument document,String token) 
	{
		String classMethod = className+ ":  modifyDocument" ;
		logger.info(String.format("Enter into "+classMethod+" (document = %s)", document));
		
		int status = 0;
		int signerId;
		int msg = 0;

		Set<Integer> uqiqueSignerId = new HashSet<Integer>();
		String userSelectSql =queryProps.getProperty("modifyDocumentIdWebservice");
		final String userInsertSql =queryProps.getProperty("modifyDocumentInsertWebservice");
		String documentSignFieldInsertSql = queryProps.getProperty("modifyDocumentSignFieldWebservice");
		String documentSignEmailInsertSql = queryProps.getProperty("modifyDocumentSignEmailWebservice");
		
		int documentId = getDocumentId(document.getEnvelopeId());
		
		if(document != null && documentId > 0)
		{
			try{
				
			
				//start insert document_sign
				
				//start getting id of signer
				KeyHolder keyHolder = new GeneratedKeyHolder();
				/*List<Integer> ids = jdbcTemplate.queryForList(userSelectSql, Integer.class,document.getSignerEmail()); 
			    if (!ids.isEmpty()) {
			    	signerId = ids.get(0);
			    }else{*/
			    	String signerEmail = document.getSignerEmail();
			    	//int index = signerEmail.indexOf('@');
			    	final String signerName = document.getSignerName();//signerEmail.substring(0,index);
			    	
			    	jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
			            PreparedStatement pst =con.prepareStatement(userInsertSql, new String[] {"id"});
			            int index = 1;
			            pst.setString(index++,signerName);
			            pst.setString(index++,document.getSignerEmail());
			            pst.setInt(index++, 0);
			            pst.setInt(index++, 0);
			            pst.setTimestamp(index++, CommonUtils.currentDate());
			            pst.setInt(index++, document.getId());
			            pst.setString(index++,CommonUtils.randomString(25));
			            
			            return pst;
			        }
			    },
			    keyHolder);
				
			    	signerId =  Integer.parseInt(keyHolder.getKey().toString());
			    	
			   // }
			  //end getting id of signer
			    
					for(final RestDocumentField documentSignField: document.getDocumentFields())
					{	
						
					    
					    //start insert document_sign_field
					    if(signerId != 0)
					    {
					    	int priority = 1;
					    	jdbcTemplate.update(documentSignFieldInsertSql,signerId,documentId,documentSignField.getPageNumber(),priority,documentSignField.getxPosition(),documentSignField.getyPosition(),documentSignField.getFieldHeight(),documentSignField.getFieldWidth(),documentSignField.getFieldValue(),documentSignField.getFieldName(),documentSignField.getFieldType(),CommonUtils.currentDate());
					    	
					    	//start insert document_sign_email
					    	if(uqiqueSignerId.add(signerId))
					    	{	
					    		int mailCount = 0;
					    		int signstatus =0;
					    		/*if(documentSignField.getPriority().equals("0")){
					    			signstatus = 1;
					    		}
					    		if(documentSignField.getPriority().equals("1"))
					    		{
					    			mailCount = 1;
					    		}*/
					    		
					    		jdbcTemplate.update(documentSignEmailInsertSql,signerId,documentId,priority,mailCount,token,signstatus,CommonUtils.currentDate());
					    		msg = signerId;
					    	}
					    	//end insert document_sign_email
					    }
					    //end insert document_sign_field
					}
			
			//end insert document_sign
			}catch(Exception e){
				msg = 0;
			}
		}else{
			msg = 0;
		}
		logger.info("exit from "+classMethod);
		return msg;
	}

	public int getDocumentId(String envelopeId)
	{
		int documentId = 0;
 		String sql = queryProps.getProperty("getDocumentIdWebservice");
		List<Integer> ids = jdbcTemplate.queryForList(sql, Integer.class,envelopeId); 
	    if (!ids.isEmpty()) {
	    	documentId = ids.get(0);
	    }
		return documentId;
	}
	
	
	public String getSignature(String signerEmail)
	{
		String sign = null;
		String getSignatue = queryProps.getProperty("getSignatue");
		List<String> ids = jdbcTemplate.queryForList(getSignatue, String.class,signerEmail); 
	    if (!ids.isEmpty()) {
	    	sign = ids.get(0);
	    }
		return sign;
	}

	@Override
	public int modifyDocumentBlob( InputStream inputStream, String envelopeId, String blobField) 
	{
	    final String sql = "update document set "+ blobField +" = ?,upload_date=? where envelopeid = ? ";
	    PreparedStatement ps = null;
		Connection con = null;
		int out=0;
		try{
			int length;
		    length = inputStream.available();
		    con = dataSource.getConnection();
			ps = con.prepareStatement(sql);
			ps.setBinaryStream(1, inputStream,length);
		    ps.setTimestamp(2, CommonUtils.currentDate());
	        ps.setString(3, envelopeId);
			out = ps.executeUpdate();
			if(out !=0){
				System.out.println("Document updated with id="+envelopeId);
			}else
				System.out.println("No Document found with id="+envelopeId);
			
		}catch(SQLException | IOException e){
			e.printStackTrace();
		}finally{
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return out;
	}

	@Override
	public int isValidEnvelopeId(String envelopeId, String email) 
	{
		String sql = queryProps.getProperty("isValidEnvelopeId");
		int msg=0;
		try{
			List<Integer> eId = jdbcTemplate.queryForList(sql, Integer.class, email, envelopeId ); 
		    if (eId.isEmpty()) 
		    {
		        msg = 0;
		    }else{
		    	msg=eId.get(0);
		    }
			
		}catch(Exception e){
			msg = 0;
		}
		return msg;
	}

	@Override
	public RestDocument getDocumentHistory(RestDocument doc1) 
	{
		String classMethod = className+ ":  getDocumentHistory" ;
		logger.info(String.format("Enter into "+classMethod+" (document = %s)", doc1));
		String sql = queryProps.getProperty("getDocumentHistory");
		RestDocument document = new RestDocument();
		String status = "";
		try{
			document = jdbcTemplate.query(sql, new Object[] { doc1.getOriginatorEmail(),doc1.getEnvelopeId() }, new ResultSetExtractor<RestDocument>()
    	    {
    			public RestDocument extractData(ResultSet rs) throws SQLException,DataAccessException 
    			{	
    				
    				if(rs.next())
    				{
    					RestDocument doc = new RestDocument();
    					doc.setDocumentName(rs.getString("name"));
    					doc.setEvent(rs.getString("status"));
    					doc.setClientIPAddress(rs.getString("client_ip_address"));
    					doc.setCreatedOn(rs.getTimestamp("upload_date"));
    		    		return doc;
    		    	}
    				return null;				
    			}
    		});
    		
			status = "Success";
		 }catch(Exception e ){
			logger.error("Error while getting getDocumentHistory: "+e);
		}
		if(document == null){
			status = "Envelope id seems invalid.";
			document = new RestDocument();
		}
		document.setStatus(status);
		document.setEnvelopeId(doc1.getEnvelopeId());
		document.setOriginatorEmail(doc1.getOriginatorEmail());
		
		logger.info("exit from "+classMethod);
		return document;
	}

	@Override
	public void saveAudit(final Audit audit) {
		// TODO Auto-generated method stub
		String classMethod = className+ ":  getDocumentHistory" ;
		logger.info(String.format("Enter into "+classMethod+" (Audit = %s)", audit));
		KeyHolder keyHolder = new GeneratedKeyHolder();
		final String query_doc = queryProps.getProperty("saveAudit");

		try{
		jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
	    	            PreparedStatement pst =con.prepareStatement(query_doc, new String[] {"id"});
	    	            int index = 1;
	                    pst.setInt(index++,audit.getUserId());
	                    pst.setString(index++,audit.getIpAddress());
	                    pst.setString(index++, audit.getWebRequest());
	                    pst.setString(index++, audit.getWebResponse());
	                    pst.setString(index++, audit.getResponseStatus());
	                    pst.setString(index++, audit.getMethodName());
	                    pst.setTimestamp(index++,audit.getCreatedOn());
	                    return pst;
	    	        }
	    	    },
	    	    keyHolder);
		}catch(Exception e){
			e.printStackTrace();
		}
		logger.info("exit from "+classMethod);
	}

	@Override
	public int createDocument(final int userId, final String fileName, final String envelopeId, final int status,final String signType,
			final String subject,final String message,final String clientIPAddress,final String returnURL) throws DaoException {
		// TODO Auto-generated method stub
		String classMethod = className+ ":  createDocument" ;
		//logger.info(String.format("Enter into "+classMethod+"(userId = %s,envelopeId = %s, fileName= %s, inputStream = %s, status = %s, signType = %s, subject = %s, message = %s, clientIPAddress = %s)", userId,envelopeId, fileName, status, signType, subject, message, clientIPAddress));
		
		int flag = 0;
		
		KeyHolder keyHolder = new GeneratedKeyHolder();
		try{
		//final int length = inputStream.available();
		final String sql = queryProps.getProperty("createDocumentWebservice1");
		final String incrementDocumentUsedCountSQL = queryProps.getProperty("incrementDocumentUsedCount");
		
			jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
	            PreparedStatement pst =con.prepareStatement(sql, new String[] {"id"});
	            int index = 1;
	            pst.setInt(index++,userId);
	            pst.setString(index++, envelopeId);
	            pst.setString(index++,fileName);
	          //  pst.setBinaryStream(index++,inputStream,length );
	            pst.setInt(index++, status);
	            pst.setString(index++, signType);
	            pst.setString(index++, subject);
	            pst.setString(index++, message);
	            pst.setString(index++, signType);
	            pst.setTimestamp(index++, CommonUtils.currentDate());
	            pst.setString(index++, clientIPAddress);
	            pst.setString(index++, "101");
	            pst.setString(index++, returnURL);
	            return pst;
	        }
	    },
	    keyHolder);
		
		logger.info("exit from "+classMethod);
		flag =  keyHolder.getKey().intValue();
	
		jdbcTemplate.update(incrementDocumentUsedCountSQL, userId);
		/*String sql1 = "update document set digital = ? where id = ? ";
		int status1 = jdbcTemplate.update(sql1, inputStream, flag);*/
		
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
		return flag;
		
	}

	@Override
	public int updateRefDocId(int documentId, String refDocId, String docType) {
		// TODO Auto-generated method stub
		String query_orignal="update Document set original_doc_id =? where id=?";
		String query_electronic="update Document set electronic_doc_id =?  where id=?";
		String query_digital="update Document set digital_doc_id =? where id=?";
		int out = 0;
		Object[] args = null;
		//JdbcTemplate jdbcTemplate = new JdbcTemplate();
		
		if (docType == "original") {
			System.out.println("Orignal doc Id");
			args = new Object[] { refDocId, documentId };
			out = jdbcTemplate.update(query_orignal, args);
		}
		if (docType == "electronic") {
			args = new Object[] { refDocId, documentId };
			out = jdbcTemplate.update(query_electronic, args);
		}
		if (docType == "digital") {
			args = new Object[] { refDocId, documentId };
			out = jdbcTemplate.update(query_digital, args);
		}

		if (out != 0) 
			System.out.println("Document updated with id=" + documentId);
		 else
			System.out.println("No Document found with id=" + documentId);
		return out;
	}

	@Override
	public String getSignUrl(int signerId) {
		// TODO Auto-generated method stub
		String sql = queryProps.getProperty("getSignUrl");
		String msg="";
		int status=0;
		try{
			List<String> eId = jdbcTemplate.queryForList(sql, String.class, signerId, status ); 
		    if (eId.isEmpty()) 
		    {
		        msg = "Document url is empty";
		    }else{
		    	msg=eId.get(0);	
		    }
			
		}catch(Exception e){
			msg = e.getMessage();
		}
		return msg;
	}

	@Override
	public SB_Purchase getActiveSubscription(final int userId) 
	{
		logger.info(String.format("getActiveSubscription(userId = %s)", userId));	    
		String sql = queryProps.getProperty("activePurchase");
		SB_Purchase purchase =null;
		try{
			purchase = jdbcTemplate.query(sql, new Object[] { userId }, new ResultSetExtractor<SB_Purchase>()
			{
			public SB_Purchase extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				if(rs.next()){
					SB_Subscription subscription = new SB_Subscription();
					subscription.setId(rs.getInt("id"));
					subscription.setUserId(userId);
					subscription.setPlanId(rs.getInt("plan_id"));
					subscription.setCreditedDocuments(rs.getInt("credited_documents"));
					subscription.setUsedDocuments(rs.getInt("used_documents"));
					subscription.setStatus(rs.getInt("status"));
					subscription.setSubscriptionStartTime(rs.getTimestamp("subscription_start_date"));
					subscription.setSubscriptionEndTime(rs.getTimestamp("subscription_end_date"));
					
					SB_Purchase purchase = new SB_Purchase();
					purchase.setPlanName(rs.getString("plan_name"));
					purchase.setDurationtime(rs.getString("noofdays"));
					purchase.setSubscription(subscription);
		    		return purchase;
		    		}
				return null;				
			}
		});		
		return (SB_Purchase) purchase;
		
		}catch(Exception e ){
			logger.error("Error while getting checkValidSubscription: "+e);
		}
		return purchase;
	}

	@Override
	public String insertSigners(String prepareKey, Map<String, Object> signersMap, RestDocument document) 
	{
		String classMethod = className+ ":  getDcoument" ;
		logger.info(String.format("Enter into "+classMethod+"(prepareKey, = %s, signersMap= %s, document=%s)",prepareKey,  signersMap,document));
		String status = "";
		String update_prepare_doc_url = queryProps.getProperty("update_prepare_doc_url");
		String select_document_id = queryProps.getProperty("select_document_id");
		String insert_signer = queryProps.getProperty("insert_signer");
		
		
		
		try
		{
			//for update prepare document url
			jdbcTemplate.update(update_prepare_doc_url,prepareKey,document.getPrepareReturnUrl(), document.getEnvelopeId());
			
			//for select document id by envelope id
			List<Integer> docIds = jdbcTemplate.queryForList(select_document_id, Integer.class,document.getEnvelopeId()); 
		    
			if (docIds !=null) 
			{
		        int documentId = docIds.get(0);
		        for (Map.Entry<String, Object> entry : signersMap.entrySet()) 
		        {
		        	String signUrl = JerseyFileUpload.randomString(25);
		            String signerName = entry.getKey();
		            Object signerEmail = entry.getValue();
		            jdbcTemplate.update(insert_signer,signerName,signerEmail,0,0,CommonUtils.currentDate(),documentId,signUrl);
		        }
		        
		        
		    } 
	
			
			
		}catch(Exception e){
			status=e.getMessage();
			logger.error("Error while insertSigners: "+e);
		}
		
		
		logger.info("exit from "+classMethod);
		return null;
	}

	@Override
	public List<DocumentSigner> getSigners(String envelopeId,String url) 
	{
		String classMethod = className+ ":  getSigners" ;
		logger.info(String.format("Enter into "+classMethod+"(envelopeId, = %s,url = %s)",envelopeId,url));
		String sql = queryProps.getProperty("get_signer");
		
		List<DocumentSigner> listSigners = new ArrayList<DocumentSigner>();
		try{ 
        List<Map<String,Object>> dfRows = jdbcTemplate.queryForList(sql,new Object[]{envelopeId});
         
        for(Map<String,Object> df : dfRows){
        	DocumentSigner signers = new DocumentSigner();
        	
        	signers.setSignerName(String.valueOf(df.get("name")));
        	signers.setSignerEmail(String.valueOf(df.get("email")));
        	signers.setSignerStatus(String.valueOf(df.get("status")));
        	signers.setSignDocumentUrl(url + String.valueOf(df.get("sign_url")));
        	
        	listSigners.add(signers);
        }
		}catch(Exception e){
			logger.error("Error while getSigners: "+e);
		}
		
		
		logger.info("exit from "+classMethod);
		return listSigners;
	}

	@Override
	public String availableSigners(String envelopeId) 
	{
		String classMethod = className+ ":  availableSigners" ;
		logger.info(String.format("Enter into "+classMethod+"(envelopeId, = %s)",envelopeId));
		
		String msg = "";
		String sql = queryProps.getProperty("availableSigners");
		try{
			List<String> eId = jdbcTemplate.queryForList(sql, String.class, envelopeId ); 
		    if (eId.isEmpty()){
		        msg = "Signer not available.";
		    }else if(!eId.isEmpty() && eId.get(0).equalsIgnoreCase("101")){
		    	msg = "Document not available for sign, Kindly prepare document before proceeding to sign.";
		    }
		    
		}catch(Exception e){
			logger.error("Error while availbleSigners:"+e);
			msg = e.getMessage();
		}
		
		logger.info("exit from "+classMethod);
		return msg;
	}

	@Override
	public CreateSignatureRequest createSignature(CreateSignatureRequest input) 
	{
		String classMethod = className+ " : createSignature";
		logger.info(String.format("Enter into "+classMethod+"(CreateSignatureRequest = %s)", input));
		String sql = queryProps.getProperty("checkAvaillabeSignature");
		try{
		List<String> token = jdbcTemplate.queryForList(sql,String.class,input.getEmail());
		if(token.isEmpty()){
			String insertSignerSignature = queryProps.getProperty("insertSignerSignature");
			jdbcTemplate.update(insertSignerSignature,input.getFirstname(),input.getLastname(),input.getEmail(),input.getToken(),0,CommonUtils.currentDate(),CommonUtils.currentDate());
			
		}else{
			input.setToken(token.get(0));
		}
		input.setMessage("success");
		}catch(Exception e){
			input.setMessage("Error while create signature: "+e);
			logger.error("Error while create signature: "+e);
		}
		return input;
	}

	@Override
	public BackgroundSignDocument backgroundSignDocumentSave(final BackgroundSignDocument document, String envelopeId,int userId) 
	{
		String classMethod = className+ " : backgroundSignDocumentSave";
		logger.info(String.format("Enter into "+classMethod+"(BackgroundSignDocument = %s, envelopeId = %s )", document,envelopeId));

		try
		{
			
			/*start insert saving into db*/
			int signerId;
			Set<Integer> uqiqueSignerId = new HashSet<Integer>();
			
			String documentSignFieldInsertSql = queryProps.getProperty("modifyDocumentSignFieldWebservice");
			String documentSignEmailInsertSql = queryProps.getProperty("modifyDocumentSignEmailWebservice");
			int documentId = getDocumentId(envelopeId);
			
			if(document != null && documentId > 0)
			{
				
				
					//start insert document_sign
				    	document.setId(documentId);
				    	List<BackgroundSignFields> updatedSignField = new ArrayList<BackgroundSignFields>();
				    	
				    	Map<String,Integer> uniqueSigner = removeDuplicateSigner(document.getDocumentFields(),documentId,userId);
				    	
						for(final BackgroundSignFields documentSignField: document.getDocumentFields())
						{	
							//start getting id of signer
							final String signerEmail = documentSignField.getSignerEmail();
					    	final String signerName = documentSignField.getSignerName();
					    	
							signerId = uniqueSigner.get(signerEmail);
							//end getting id of signer
							//start insert document_sign_field
							
						    if(signerId != 0)
						    {
						    	int priority = 1;
						    	//get signature if field is sign type.
						    	if("sign".equals(documentSignField.getFieldName()))
						    	{
						    		String signature = getSignature(signerEmail);
							    	if(signature !=null ){
							    		documentSignField.setFieldValue(signature);
							    	}else{
							    		documentSignField.setFieldValue(signerName);
							    		documentSignField.setFieldType("text");
							    	}
						    	}
						    	
						    	jdbcTemplate.update(documentSignFieldInsertSql,signerId,documentId,documentSignField.getPageNumber(),priority,documentSignField.getxPosition(),documentSignField.getyPosition(),documentSignField.getFieldHeight(),documentSignField.getFieldWidth(),documentSignField.getFieldValue(),documentSignField.getFieldName(),documentSignField.getFieldType(),CommonUtils.currentDate());
						    	
						    	//start insert document_sign_email
						    	if(uqiqueSignerId.add(signerId))
						    	{	
					    		int mailCount = 0;
					    		int signstatus =1;
					    		jdbcTemplate.update(documentSignEmailInsertSql,signerId,documentId,priority,mailCount,null,signstatus,CommonUtils.currentDate());
					    		
					    	}
						   	
						    	updatedSignField.add(documentSignField);
						    
						    //end insert document_sign_email
						    }
						    //end insert document_sign_field
						   
					}
				 if(updatedSignField !=null && updatedSignField.size()>0){
					 document.setDocumentFields(updatedSignField);
					 document.setMessage("success");
				 }
				//end insert document_sign
				
			}else{
				document.setMessage("Invalid document.");
			}
			/* end inserting db*/
			
			
		
		}catch(Exception e){
			String eMSG = "Error while create signature: "+e;
			document.setMessage(eMSG);
			logger.error(eMSG);
		}
		return document;
	}

	
	public Map<String,Integer> removeDuplicateSigner(List<BackgroundSignFields> fields, final int documentId, final int userId)
	{
		final String userInsertSql =queryProps.getProperty("insertSignerWebservice");
		Set<String> email = new HashSet<String>();
		Map<String,Integer> signers = new HashMap<String,Integer>();
		for(final BackgroundSignFields field : fields)
		{
			if(email.add(field.getSignerEmail()))
			{
				KeyHolder keyHolder = new GeneratedKeyHolder();
		    	jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
		            PreparedStatement pst =con.prepareStatement(userInsertSql, new String[] {"id"});
		            int index = 1;
		            pst.setString(index++,field.getSignerName());
		            pst.setString(index++,field.getSignerEmail());
		            pst.setInt(index++, 0);
		            pst.setInt(index++, 0);
		            pst.setTimestamp(index++, CommonUtils.currentDate());
		            pst.setInt(index++, userId);
		            pst.setString(index++,CommonUtils.randomString(25));
		            pst.setInt(index++, documentId);
		            return pst;
			        }
			    },
			    keyHolder);
				int signerId = Integer.parseInt(keyHolder.getKey().toString());

				signers.put(field.getSignerEmail(), signerId);
			}
			
		}
		
		return signers;
	}

	@Override
	public String updateDocument(int status, int docStatus, Timestamp currentDate, int documentId) 
	{
		String query = queryProps.getProperty("saveOrUpdateDocument");

		Object[] args = new Object[] { status, docStatus, currentDate, documentId };

		int out = jdbcTemplate.update(query, args);
		if (out != 0) {
			logger.info("document updated with id=" + documentId);
			return "success";
		}
		logger.info("problem with document updated with id=" + documentId);
		return "fail";
	}
	
	
	
}
