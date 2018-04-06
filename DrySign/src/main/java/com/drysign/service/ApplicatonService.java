package com.drysign.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.drysign.dao.DaoException;
import com.drysign.model.ApplicationDocument;
import com.drysign.model.Document;
import com.drysign.model.DocumentCount;
import com.drysign.model.DocumentField;
import com.drysign.model.Draft;
import com.drysign.model.JsonDocumentData;
import com.drysign.model.Notification;
import com.drysign.model.Signature;
import com.drysign.model.SignerData;
import com.drysign.utility.Signer;

@Service("adminService")
public interface ApplicatonService {

	String insertDocument(int userid, String name, String envelopId, String docRefId, int status, String type,
			String signType, String ipAddress, int docStatus) throws DaoException;

	String insertDraft(int docId, int stepNumber, String url) throws DaoException;
	
	ApplicationDocument getDocument(int fileId,int userId) throws DaoException;
	
	public String updateDraft(int stepNumber,int draftId,String url,int incrementor);
	
	public String deleteDraft(int docId);
	
	public Draft getDocumentDraft(int docId)throws DaoException;
	
	public void updateRefDocId(int documentId,String refDocId,String docType);
	
	public String saveDocumentFields(List<DocumentField> documentField);
	
	public String deleteDocumentFields(int docId);
	
	public String updateDocument(ApplicationDocument document);
	
	public String updateDocument1(ApplicationDocument document);
	
	public String saveNotification(Notification notification)throws DaoException;
	
	public String deleteDocument(String docStatus,int docId, int i);
	
	public List<JsonDocumentData> completedDocuments(int userId);
	
	public List<JsonDocumentData> getDraft(int userId);

	String saveSetting(String project, String theme);
	
	public DocumentCount getDocumentCount(int id) throws DaoException;
	
	public int saveSignature(int id, String dataURL,String signType);
	
	public ApplicationDocument getSignature(int id,int flag)throws DaoException;
	
	public String getPic(int id,int flag);
	
	public int savePhoto(int id, String dataURL);
	
	public int getDocumentId(String envelopeId,int userId);
	
	public String saveTempSigner(List<DocumentField> docField);
	
	public List<DocumentField> getTempSigner(int docId);
	
	public String saveGroupSignFields(List<DocumentField> documentField);
	
	public int saveGroupSigner(Signer signer);
	
	public String getSignerToken(int signerId);
	
	public SignerData checkValidSigneKey(String key)throws DaoException;
	
	public List<DocumentField> getApplicationFieldData(String documentName, String fileid, String signeremail) throws DaoException;
	
	public List<JsonDocumentData> outForSignature(int userId);
	
	public String updateSignerFields(List<DocumentField> documentField);
	
	public boolean getAllSignerStatus(int docId,int signerId);
	
	public String updateSignerStatus(int signerId,String signDocId,int signerStatus);
	
	public String updateSignerEmail(String signerName,String token,int signerId,String newEmail,int docId);
	
	public Signer nextSignerData(int docId,int priority)throws DaoException;
	
	public Document checkValidPrepareKey(String key)throws DaoException;
	
	public List<Signer> getSignerList(int docId);
	
	public List<Signer> getSignerList1(int docId);

	ApplicationDocument getDocumentByEnvelopeId(String envelopeId) throws DaoException;
	
	public Signature getSignature(String token,String email)throws DaoException;
	
	public String saveUserSignature(Signature userSignature)throws DaoException;
	
	public String removeSigner(int docId,int signerId);
	
	public String updateSignerPriority(Signer signer);
}


