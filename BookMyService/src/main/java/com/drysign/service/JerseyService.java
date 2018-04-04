package com.drysign.service;

import java.io.InputStream;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.drysign.dao.DaoException;
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

@Component
public interface JerseyService {

	public String addUserJersey(ClientUser clientUser) throws DaoException;

	public List<ClientUser> getAllClientUserService(ClientAuth clientUserAuth) throws DaoException;

	public String addDocumentService(DocumentWrapper documentWrapper) throws DaoException;

	public ClientUser getClientUser(int originatorId) throws DaoException;

	public List<DocumentField> getFieldData(String documentName) throws DaoException;
	
	public int[] saveDocumentFields(List<DocumentField> documentField) throws DaoException;
	
	public VerifyDetails updateDocument(String documentName) throws DaoException;

	public boolean readValidFileFromOriginator(int id, String token,String fname, String semail, String oemail) throws DaoException;

	public ApplicationDocument getDocument(String documentId) throws DaoException;

	public int createDocument(int userId, String fileName,String envelopeId, InputStream inputStream, int status, String signType, String subject, String message, String clientIPAddress) throws DaoException;
	
	public int createDocument(int userId, String fileName,String envelopeId,  int status, String signType, String subject, String message, String clientIPAddress,String returnURL) throws DaoException;

	public Registration getUser(String email) throws DaoException;

	public int modifyDocument(RestDocument documentWrapper, String token);

	public int modifyDocumentBlob(InputStream inputStream, String envelopeId,String blobField);

	public int isValidEnvelopeId(String envelopeId, String email);

	public RestDocument getDocumentHistory(RestDocument document);

	public void saveAudit(Audit audit);
	
	public int updateRefDocId(int documentId,String refDocId,String docType);
	
	public String getSignUrl(int signerId);
	
	public SB_Purchase getActiveSubscription(int id);

	public String insertSigners(String prepareKey, Map<String, Object> signersMap, RestDocument document);

	public List<DocumentSigner> getSigners(String envelopeId, String url);

	public String availableSigners(String envelopeId);

	public ApplicationDocument getDocument(Download download) throws DaoException;

	public CreateSignatureRequest createSignature(CreateSignatureRequest input);

	public BackgroundSignDocument backgroundSignDocumentSave(BackgroundSignDocument document, String envelopeId, int userId);

	public String updateDocument(int status, int docStatus, Timestamp currentDate, int documentId);
}
