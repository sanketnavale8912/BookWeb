package com.drysign.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drysign.dao.ApplicatonDao;
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

@Service("applicationService")
public class ApplicatonServiceImpl implements ApplicatonService {
	@Autowired
	ApplicatonDao applicationDao;

	@Override
	public String insertDocument(int userid, String name, String envelopId, String docRefId, int status, String type,
			String signType, String ipAddress,int docStatus) throws DaoException {
	
		return applicationDao.insertDocument(userid, envelopId, name, docRefId, status, type, signType, ipAddress,docStatus);
	}

	@Override
	public String insertDraft(int docId, int stepNumber, String url) throws DaoException {
		
		return applicationDao.insertDraft(docId, stepNumber, url);
	}

	@Override
	public ApplicationDocument getDocument(int fileId,int userId) throws DaoException {
		
		return applicationDao.getDocument(fileId,userId);
	}

	@Override
	public String updateDraft(int stepNumber, int draftId,String url,int incrementor) {
		
		return applicationDao.updateDraftt(stepNumber, draftId,url,incrementor);
		
	}

	@Override
	public void updateRefDocId(int documentId, String refDocId, String docType) {
		
		 applicationDao.updateRefDocId(documentId, refDocId, docType);
		
	}

	@Override
	public String saveDocumentFields(List<DocumentField> documentField) {
	
		return applicationDao.saveDocumentFields(documentField);
	}

	@Override
	public String deleteDocumentFields(int docId) {
	
		return applicationDao.deleteDocumentFields(docId);
	}

	@Override
	public String updateDocument(ApplicationDocument document) {
		
		return applicationDao.updateDocument(document);
	}
	
	@Override
	public String updateDocument1(ApplicationDocument document) {
		
		return applicationDao.updateDocument1(document);
	}

	@Override
	public String deleteDraft(int docId) {
		
		return applicationDao.deleteDraft(docId);
	}

	@Override
	public String saveNotification(Notification notification)throws DaoException {
		
		return applicationDao.saveNotification(notification);
	}

	@Override
	public String deleteDocument(String docStatus,int docId,int userId) {
		
		return applicationDao.deleteDocument(docStatus, docId,userId);
	}

	@Override
	public List<JsonDocumentData> completedDocuments(int userId) {
		
		return applicationDao.completedDocuments(userId);
	}

	@Override
	public List<JsonDocumentData> getDraft(int userId) {
		
		return applicationDao.getDraft(userId);
		
	}

	@Override
	public Draft getDocumentDraft(int docId)throws DaoException {
		
		return applicationDao.getDocumentDraft(docId);
	}

	@Override
	public String saveSetting(String project, String theme) {
		
		return applicationDao.saveSetting(project, theme);
	}

	@Override
	public DocumentCount getDocumentCount(int id) throws DaoException {
		return applicationDao.getDocumentCount(id);
	}

	@Override
	public int saveSignature(int id, String dataURL,String signType) {
		
		return applicationDao.saveSignature(id,dataURL,signType);
	}

	@Override
	public int savePhoto(int id, String dataURL) {
		// TODO Auto-generated method stub
		return applicationDao.savePhoto(id, dataURL);
	}

	@Override
	public ApplicationDocument getSignature(int id, int flag)throws DaoException {
		// TODO Auto-generated method stub
		return applicationDao.getSignature(id, flag);
	}

	@Override
	public int getDocumentId(String envelopeId, int userId) {
		// TODO Auto-generated method stub
		return applicationDao.getDocumentId(envelopeId, userId);
	}

	@Override
	public String saveTempSigner(List<DocumentField> docField) {
		// TODO Auto-generated method stub
		return applicationDao.saveTempSigner(docField);
	}

	@Override
	public List<DocumentField> getTempSigner(int docId) {
		// TODO Auto-generated method stub
		return applicationDao.getTempSigner(docId);
	}

	@Override
	public String saveGroupSignFields(List<DocumentField> documentField) {
		// TODO Auto-generated method stub
		return applicationDao.saveGroupSignFields(documentField);
	}

	@Override
	public int saveGroupSigner(Signer signer) {
		// TODO Auto-generated method stub
		return applicationDao.saveGroupSigner(signer);
	}

	@Override
	public String getSignerToken(int signerId) {
		// TODO Auto-generated method stub
		return applicationDao.getSignerToken(signerId);
	}

	@Override
	public SignerData checkValidSigneKey(String key)throws DaoException {
		// TODO Auto-generated method stub
		return applicationDao.checkValidSigneKey(key);
	}

	@Override
	public List<DocumentField> getApplicationFieldData(String documentName, String fileid, String signeremail)
			throws DaoException {
		// TODO Auto-generated method stub
		return applicationDao.getApplicationFieldData(documentName, fileid, signeremail);
	}

	@Override
	public List<JsonDocumentData> outForSignature(int userId) {
		// TODO Auto-generated method stub
		return applicationDao.outForSignature(userId);
	}

	@Override
	public String updateSignerFields(List<DocumentField> documentField) {
		// TODO Auto-generated method stub
		return applicationDao.updateSignerFields(documentField);
	}

	@Override
	public boolean getAllSignerStatus(int docId, int signerId) {
		// TODO Auto-generated method stub
		return applicationDao.getAllSignerStatus(docId, signerId);
	}

	@Override
	public String updateSignerStatus(int signerId, String signDocId, int signerStatus) {
		// TODO Auto-generated method stub
		return applicationDao.updateSignerStatus(signerId, signDocId, signerStatus);
	}

	@Override
	public Signer nextSignerData(int docId, int priority)throws DaoException {
		// TODO Auto-generated method stub
		return applicationDao.nextSignerData(docId, priority);
	}

	@Override
	public String getPic(int id, int flag) {
		// TODO Auto-generated method stub
		return applicationDao.getPic(id, flag);
	}

	@Override
	public Document checkValidPrepareKey(String key) throws DaoException {
		// TODO Auto-generated method stub
		return applicationDao.checkValidPrepareKey(key);
	}

	@Override
	public List<Signer> getSignerList(int docId) {
		// TODO Auto-generated method stub
		return applicationDao.getSignerList(docId);
	}
	@Override
	public List<Signer> getSignerList1(int docId) {
		// TODO Auto-generated method stub
		return applicationDao.getSignerList1(docId);
	}
	@Override
	public ApplicationDocument getDocumentByEnvelopeId(String envelopeId) throws DaoException {
		
		return applicationDao.getDocumentByEnvelopeId(envelopeId);
	}

	@Override
	public Signature getSignature(String token,String email)throws DaoException {
		// TODO Auto-generated method stub
		return applicationDao.getSignature(token,email);
	}

	@Override
	public String saveUserSignature(Signature userSignature) throws DaoException {
		// TODO Auto-generated method stub
		return applicationDao.saveUserSignature(userSignature);
	}

	@Override
	public String updateSignerEmail(String signerName,String token,int signerId,String newEmail,int docId){
		// TODO Auto-generated method stub
		return applicationDao.updateSignerEmail(signerName,token,signerId, newEmail,docId);
	}

	@Override
	public String removeSigner(int docId, int signerId) {
		// TODO Auto-generated method stub
		return applicationDao.removeSigner(docId, signerId);
	}

	@Override
	public String updateSignerPriority(Signer signer) {
		// TODO Auto-generated method stub
		return applicationDao.updateSignerPriority(signer);
	}
}
