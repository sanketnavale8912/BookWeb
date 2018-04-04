package com.drysign.service;

import java.io.InputStream;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drysign.dao.DaoException;
import com.drysign.dao.JerseyDao;
import com.drysign.model.ApplicationDocument;
import com.drysign.model.Audit;
import com.drysign.model.BackgroundSignDocument;
import com.drysign.model.ClientAuth;
import com.drysign.model.ClientUser;
import com.drysign.model.CreateSignatureRequest;
import com.drysign.model.DocumentField;
import com.drysign.model.DocumentSigner;
import com.drysign.model.DocumentWrapper;
import com.drysign.model.Download;
import com.drysign.model.Registration;
import com.drysign.model.RestDocument;
import com.drysign.model.SB_Purchase;
import com.drysign.model.VerifyDetails;

@Service("jerseyService")
public class JerseyServiceImpl implements JerseyService {

	@Autowired
	private JerseyDao jerseyDao;
	
	public String addUserJersey(ClientUser clientUser) throws DaoException {
		
		return jerseyDao.addUserJersey(clientUser);
	}

	public List<ClientUser> getAllClientUserService(ClientAuth clientUserAuth) throws DaoException 
	{
		return jerseyDao.getAllClientUserDao(clientUserAuth);
	}

	public String addDocumentService(DocumentWrapper documentWrapper) throws DaoException {
		
		return jerseyDao.addDocumentDao(documentWrapper);
	}

	public ClientUser getClientUser(int originatorId) throws DaoException {
		
		return jerseyDao.getClientUserDao(originatorId);
	}


	@Override
	public List<DocumentField> getFieldData(String documentName) throws DaoException {
		return jerseyDao.getFieldData(documentName);
	}

	@Override
	public int[] saveDocumentFields(List<DocumentField> documentField) throws DaoException {
		return jerseyDao.saveDocumentFields(documentField);
	}

	@Override
	public VerifyDetails updateDocument(String documentName) throws DaoException {
		return jerseyDao.updateDocument(documentName);
	}

	@Override
	public boolean readValidFileFromOriginator(int id, String token,String fname, String semail, String oemail) throws DaoException 
	{	
		return jerseyDao.readValidFileFromOriginator(id,token,fname,semail,oemail);
	}

	@Override
	public ApplicationDocument getDocument(String documentId) throws DaoException {
		
		return jerseyDao.getDcoument(documentId);
	}

	@Override
	public int createDocument(int userId, String envelopeId,String fileName,InputStream inputStream, int status, String signType, String subject, String message, String clientIPAddress) throws DaoException {
	
		return jerseyDao.createDocument(userId, envelopeId, fileName, inputStream, status, signType, subject, message, clientIPAddress);
	}

	@Override
	public Registration getUser(String email) throws DaoException {
		
		return jerseyDao.getUser(email);
	}

	@Override
	public int modifyDocument(RestDocument documentWrapper, String token) {
		
		return jerseyDao.modifyDocument(documentWrapper, token);
	}

	@Override
	public int modifyDocumentBlob(InputStream inputStream,String envelopeId, String blobField) 
	{
		
		return jerseyDao.modifyDocumentBlob(inputStream, envelopeId, blobField);
	}

	@Override
	public int isValidEnvelopeId(String envelopeId, String email) 
	{
		
		return jerseyDao.isValidEnvelopeId(envelopeId, email);
	}

	@Override
	public RestDocument getDocumentHistory(RestDocument document) 
	{
		return jerseyDao.getDocumentHistory(document);
	}

	@Override
	public void saveAudit(Audit audit){
		// TODO Auto-generated method stub
		jerseyDao.saveAudit(audit);
	}

	@Override
	public int createDocument(int userId, String fileName, String envelopeId, int status, String signType,
			String subject, String message, String clientIPAddress,String returnURL) throws DaoException {
		// TODO Auto-generated method stub
		return jerseyDao.createDocument(userId, envelopeId, fileName, status, signType, subject, message, clientIPAddress,returnURL);
	}

	@Override
	public int updateRefDocId(int documentId, String refDocId, String docType) {
		// TODO Auto-generated method stub
		return  jerseyDao.updateRefDocId(documentId, refDocId, docType);
	}

	@Override
	public String getSignUrl(int signerId) {
		// TODO Auto-generated method stub
		return jerseyDao.getSignUrl(signerId);
	}

	@Override
	public SB_Purchase getActiveSubscription(int id) {
		// TODO Auto-generated method stub
		return jerseyDao.getActiveSubscription(id);
	}

	@Override
	public String insertSigners(String prepareKey,Map<String, Object> signersMap, RestDocument document) 
	{
		return jerseyDao.insertSigners(prepareKey,signersMap,document);
	}

	@Override
	public List<DocumentSigner> getSigners(String envelopeId, String url) {

		return jerseyDao.getSigners(envelopeId, url);
	}

	@Override
	public String availableSigners(String envelopeId) 
	{
		return jerseyDao.availableSigners(envelopeId);
	}

	@Override
	public ApplicationDocument getDocument(Download download) throws DaoException {
		
		return jerseyDao.getDcoument(download);
	}

	@Override
	public CreateSignatureRequest createSignature(CreateSignatureRequest input) {
		
		return jerseyDao.createSignature(input);
	}

	@Override
	public BackgroundSignDocument backgroundSignDocumentSave(BackgroundSignDocument document, String envelopeId, int userId) {
	
		return jerseyDao.backgroundSignDocumentSave(document, envelopeId, userId);
	}

	@Override
	public String updateDocument(int status, int docStatus, Timestamp currentDate, int documentId) {

		return jerseyDao.updateDocument( status,  docStatus, currentDate,documentId);
		
	}

	
	


}
