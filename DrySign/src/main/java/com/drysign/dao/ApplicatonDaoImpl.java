package com.drysign.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.sql.DataSource;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.text.WordUtils;

import com.drysign.model.ApplicationDocument;
import com.drysign.model.Document;
import com.drysign.model.DocumentCount;
import com.drysign.model.DocumentField;
import com.drysign.model.Draft;
import com.drysign.model.JsonDocumentData;
import com.drysign.model.Notification;
import com.drysign.model.Signature;
import com.drysign.model.SignerData;
import com.drysign.utility.CommonUtils;
import com.drysign.utility.GlobalFunctions;
import com.drysign.utility.Signer;

@Repository("applicatonDao")
@Transactional
public class ApplicatonDaoImpl implements ApplicatonDao {

	public final static String SUCCESS = "success";
	public final static String FAILURE = "failure";

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private Properties queryProps;

	private final static Logger logger = Logger.getLogger(RegistrationDaoImpl.class);
	String className = this.getClass().getSimpleName();

	@Override
	public String insertDocument(final int userid, final String envelopeId, final String filename,
			final String docRefId, final int status, final String type, final String signType, final String ipAddress,
			final int docStatus) throws DaoException {
		String classMethod = className + ":  insertDocument";
		logger.info(String.format(
				"Enter into " + classMethod
						+ "(userid = %s,filename= %s, inputStream = %s, status = %s, type = %s, signType = %s, ipAddress = %s)",
				userid, filename, docRefId, status, type, signType, ipAddress));
		KeyHolder keyHolder = new GeneratedKeyHolder();
		try {

			final String sql = queryProps.getProperty("insertDocumentApp");
			final String incrementDocumentUsedCountSQL = queryProps.getProperty("incrementDocumentUsedCount");

			jdbcTemplate.update(new PreparedStatementCreator() {
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement pst = con.prepareStatement(sql, new String[] { "id" });
					int index = 1;
					pst.setInt(index++, userid);
					pst.setString(index++, envelopeId);
					pst.setString(index++, filename);
					pst.setString(index++, docRefId);
					pst.setInt(index++, status);
					pst.setString(index++, type);
					pst.setString(index++, signType);
					pst.setTimestamp(index++, CommonUtils.currentDate());
					pst.setString(index++, ipAddress);
					pst.setInt(index++, docStatus);
					return pst;
				}
			}, keyHolder);
			logger.info("exit from " + classMethod);
			
			//incrementDocumentUsedCount
			
			jdbcTemplate.update(incrementDocumentUsedCountSQL, userid);
			
			return keyHolder.getKey().toString();

		} catch (Exception e) {
			throw new DaoException(e.getMessage());
		}

	}

	@Override
	public String insertDraft(final int docId, final int stepNumber, final String url) throws DaoException {
		// TODO Auto-generated method stub
		String classMethod = className + ":  insertDocument";
		logger.info(String.format("Enter into " + classMethod + "(userid = %s,stepNumber= %s, url = %s)", docId,
				stepNumber, url));
		KeyHolder keyHolder = new GeneratedKeyHolder();
		try {

			final String sql = queryProps.getProperty("insertDraftApp");

			jdbcTemplate.update(new PreparedStatementCreator() {
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement pst = con.prepareStatement(sql, new String[] { "id" });
					int index = 1;
					pst.setInt(index++, docId);
					pst.setInt(index++, stepNumber);
					pst.setString(index++, url);
					return pst;
				}
			}, keyHolder);
			logger.info("exit from " + classMethod);
			return keyHolder.getKey().toString();

		} catch (Exception e) {
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public ApplicationDocument getDocument(int fileId,int userId) throws DaoException {
		// TODO Auto-generated method stub
		String classMethod = className + ":  readDocument";
		logger.info(String.format("Enter into " + classMethod + "(fileId = %s)", fileId));
		String sql = queryProps.getProperty("getReadDocumentApp");

		try {
			ApplicationDocument document = jdbcTemplate.query(sql, new Object[] { fileId ,userId},
					new ResultSetExtractor<ApplicationDocument>() {
						public ApplicationDocument extractData(ResultSet rs) throws SQLException, DataAccessException {
							if (rs.next()) {
								ApplicationDocument doc = new ApplicationDocument();
								doc.setId(rs.getInt("id"));
								doc.setUserId(rs.getInt("user_id"));
								doc.setSignType(rs.getString("sign_type"));
								doc.setEnvelopeId(rs.getString("envelopeid"));
								doc.setFileName(rs.getString("name"));
								doc.setOriginalId(rs.getString("original_doc_id"));
								doc.setElectronicId(rs.getString("electronic_doc_id"));
								doc.setDigitalld(rs.getString("digital_doc_id"));
								doc.setOriginal(rs.getBlob("original") == null ? null
										: rs.getBlob("original").getBinaryStream());
								doc.setElectronic(rs.getBlob("electronic") == null ? null
										: rs.getBlob("electronic").getBinaryStream());
								doc.setDigital(
										rs.getBlob("digital") == null ? null : rs.getBlob("digital").getBinaryStream());
								doc.setDocStatus(rs.getString("doc_status"));
								doc.setSubject(rs.getString("subject"));
								doc.setMessage(rs.getString("message"));
								doc.setCc(rs.getString("cc"));
								doc.setDocUrl(rs.getString("doc_url"));
								return doc;
							}
							return null;
						}
					});
			logger.info("exit from " + classMethod);
			return document;

		} catch (Exception e) {
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public String updateDraftt(int stepNumber, int draftId, String url,int incrementor) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("saveOrUpdateDraft");
		String query1 = queryProps.getProperty("saveOrUpdateDraft1");
		if(url != ""){
			Object[] args = new Object[] { stepNumber, url,incrementor, draftId};
			
			int out = jdbcTemplate.update(query, args);
			if (out != 0) {
				logger.info("draft updated with id=" + draftId);
				return SUCCESS;
			}
			
		}else{
			Object[] args = new Object[] { stepNumber,url, draftId };
			
			int out = jdbcTemplate.update(query1, args);
			if (out != 0) {
				logger.info("draft updated with id=" + draftId);
				return SUCCESS;
			}
		}
		logger.info("problem with draft updated with id=" + draftId);
		return FAILURE;
		
	}

	@Override
	public void updateRefDocId(int documentId, String refDocId, String docType) {
		// TODO Auto-generated method stub
		String query_orignal = "update Document set original_doc_id =? where id=?";
		String query_electronic = "update Document set electronic_doc_id =?  where id=?";
		String query_digital = "update Document set digital_doc_id =? where id=?";
		int out = 0;
		Object[] args = null;
		// JdbcTemplate jdbcTemplate = new JdbcTemplate();

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
	}

	@Override
	public String saveDocumentFields(final List<DocumentField> documentField) {
		// TODO Auto-generated method stub
		int[] updateCnt = null;
		int toatalPageNo=documentField.get(0).getNumpages();
		logger.info("saveDocumentFields:  toatalPageNo"+toatalPageNo);
		final List<DocumentField> newDocField=new ArrayList<DocumentField>();
		for(DocumentField df:documentField){
			if(df.getPageNumber() <= toatalPageNo){
				newDocField.add(df);
			}
		}
		
		try {
			updateCnt = jdbcTemplate.batchUpdate(queryProps.getProperty("saveDocumentFieldsSelfSign"),
					new BatchPreparedStatementSetter() {
						public void setValues(PreparedStatement ps, int i) throws SQLException {
							ps.setInt(1, newDocField.get(i).getUserId());
							ps.setInt(2, newDocField.get(i).getDocId());
							ps.setInt(3, newDocField.get(i).getPageNumber());
							ps.setInt(4, newDocField.get(i).getPriority());
							ps.setFloat(5, newDocField.get(i).getxPosition());
							ps.setFloat(6, newDocField.get(i).getyPosition());
							ps.setFloat(7, newDocField.get(i).getFieldHeight());
							ps.setFloat(8, newDocField.get(i).getFieldWidth());
							ps.setString(9, newDocField.get(i).getFieldValue());
							ps.setString(10, newDocField.get(i).getFieldName());
							ps.setString(11, newDocField.get(i).getFieldType());
							ps.setTimestamp(12, CommonUtils.currentDate());
						}

						public int getBatchSize() {
							return documentField.size();
						}
					});

		} catch (Exception e) {
			logger.info("Problem while updating document fields " + e.getMessage());
			e.printStackTrace();
		}
		if (updateCnt.length > 0) {
			logger.info("document field insertion success");
			return SUCCESS;
		}
		logger.info("document field insertion failure");
		return FAILURE;
	}

	@Override
	public String deleteDocumentFields(int docId) {
		// TODO Auto-generated method stub
		logger.info("[Start]  deleteDocumentFields");
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("deleteDocumentFields");

		Object[] args = new Object[] { docId };

		int out = jdbcTemplate.update(query, args);
		if (out != 0) {
			logger.info("document updated with id=" + docId);
			logger.info("[End] SelfSign saveOrUpdateDocument");
			return SUCCESS;
		}
		logger.info("problem with document updated with id=" + docId);
		return FAILURE;
	}

	@Override
	public String updateDocument(ApplicationDocument doc) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("saveOrUpdateDocument");

		Object[] args = new Object[] { doc.getStatus(), doc.getDocStatus(),doc.getUpdatedOn(), doc.getCompletedOn(),doc.getSubject(),doc.getMessage(),doc.getId() };

		int out = jdbcTemplate.update(query, args);
		if (out != 0) {
			logger.info("document updated with id=" + doc.getId());
			return SUCCESS;
		}
		logger.info("problem with document updated with id=" + doc.getId());
		return FAILURE;
	}
	
	@Override
	public String updateDocument1(ApplicationDocument doc) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("saveOrUpdateDocument1");

		Object[] args = new Object[] { doc.getStatus(), doc.getDocStatus(), doc.getCompletedOn(),doc.getSubject(),doc.getMessage(),doc.getId() };

		int out = jdbcTemplate.update(query, args);
		if (out != 0) {
			logger.info("document updated with id=" + doc.getId());
			return SUCCESS;
		}
		logger.info("problem with document updated with id=" + doc.getId());
		return FAILURE;
	}

	@Override
	public String deleteDraft(int docId) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("deleteDraft");

		Object[] args = new Object[] { docId };

		int out = jdbcTemplate.update(query, args);
		if (out != 0) {
			logger.info("draft updated with id=" + docId);
			return SUCCESS;
		}
		logger.info("problem with document updated with id=" + docId);
		return FAILURE;
	}

	@Override
	public String saveNotification(final Notification notification) throws DaoException {
		// TODO Auto-generated method stub
		String classMethod = className + ":  saveNotification";

		KeyHolder keyHolder = new GeneratedKeyHolder();
		try {

			final String sql = queryProps.getProperty("saveNotification");

			jdbcTemplate.update(new PreparedStatementCreator() {
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement pst = con.prepareStatement(sql, new String[] { "id" });
					int index = 1;
					pst.setInt(index++, notification.getDocId());
					pst.setInt(index++, notification.getUserId());
					pst.setString(index++, notification.getSubject());
					pst.setString(index++, notification.getMessage());
					pst.setString(index++, notification.getFrom());
					pst.setString(index++, notification.getTo());
					pst.setString(index++, notification.getCc());
					pst.setString(index++, notification.getStatus());
					pst.setString(index++, notification.getReason());
					pst.setTimestamp(index++, notification.getCreatedOn());
					return pst;
				}
			}, keyHolder);
			logger.info("exit from " + classMethod);
			return keyHolder.getKey().toString();

		} catch (Exception e) {
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public String deleteDocument(String docStatus, int docId,int userId) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("deleteDocument");
		String decrementDocumentUsedCountSQL = queryProps.getProperty("decrementDocumentUsedCount");

		Object[] args = new Object[] { docStatus, docId };

		int out = jdbcTemplate.update(query, args);
		if (out != 0) {
			logger.info("document updated with id=" + docId);
			jdbcTemplate.update(decrementDocumentUsedCountSQL, userId);
			return SUCCESS;
		}
		logger.info("problem with document updated with id=" + docId);
		return FAILURE;
	}

	/***
	 * @author Sanket.Navale
	 * 
	 *         Get Completed Document Data from DB
	 * @UserId
	 */
	@Override
	public List<JsonDocumentData> completedDocuments(int userId) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("completedDocuments");

		String query1 = queryProps.getProperty("completedDocumentsPriority");
		List<JsonDocumentData> docList = new ArrayList<JsonDocumentData>();

		List<Map<String, Object>> jsonRows = jdbcTemplate.queryForList(query, new Object[] { userId });

		for (Map<String, Object> jsonRow : jsonRows) {
			JsonDocumentData doc = new JsonDocumentData();
			doc.setDocId(Integer.parseInt(String.valueOf(jsonRow.get("docId"))));
			doc.setEnvelopeId(String.valueOf(jsonRow.get("envelopeId")));
			doc.setDocumentName(String.valueOf(jsonRow.get("documentName")));
			doc.setSubject(String.valueOf(jsonRow.get("subject")));
			doc.setMessage(String.valueOf(jsonRow.get("message")));
			doc.setSignerEmail(String.valueOf(jsonRow.get("signerEmail")));
			doc.setRequestedBy(String.valueOf(jsonRow.get("requestedBy")));
			doc.setSignedUser(String.valueOf(jsonRow.get("signedUser")));
			doc.setCompletedDate(String
					.valueOf(jsonRow.get("completedDate") == null ? "" : String.valueOf(jsonRow.get("completedDate"))));
			doc.setStatus(String.valueOf(jsonRow.get("status")));
			doc.setSignType(String.valueOf(jsonRow.get("signType")));

			docList.add(doc);
		}
		for (JsonDocumentData jd : docList) {
			if (jd.getSignType().equalsIgnoreCase("G") || jd.getSignType().equalsIgnoreCase("R")) {
				int docId = jd.getDocId();
				List<String> signerNameList = new ArrayList<String>();
				List<String> signerStatusList = new ArrayList<String>();
				List<String> priorityList = new ArrayList<String>();
				List<String> emailCountList = new ArrayList<String>();
				List<String> emailIDList = new ArrayList<String>();
				List<Map<String, Object>> sRows = jdbcTemplate.queryForList(query1, new Object[] { docId });
				//int count = 1;
				for (Map<String, Object> sRow : sRows) {
					signerNameList.add(String.valueOf(sRow.get("signerName")));
					signerStatusList.add(String.valueOf(sRow.get("signerStatus")));
					String priority = String.valueOf(sRow.get("priority"));
					/*if (priority.equals("0")) {
						count += 0;
					}*/
					priorityList.add(String.valueOf(priority));
					//count++;
					//emailCountList.add((String.valueOf(sRow.get("emailCount"))));
					emailIDList.add((String.valueOf(sRow.get("signerEmailId"))));

				}
				jd.setSignerName(StringUtils.join(signerNameList, ','));
				jd.setSignerStatus(StringUtils.join(signerStatusList, ','));
				jd.setPriority(StringUtils.join(priorityList, ','));
				jd.setEmailCount(StringUtils.join(emailCountList, ','));
				jd.setSignerEmailId(StringUtils.join(emailIDList, ','));
			}
		}

		return docList;

	}

	@Override
	public List<JsonDocumentData> getDraft(int userId) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("getDraft");
		List<JsonDocumentData> docList = new ArrayList<JsonDocumentData>();
		List<Map<String, Object>> jsonRows = jdbcTemplate.queryForList(query, new Object[] { userId });
		for (Map<String, Object> jsonRow : jsonRows) {
			JsonDocumentData doc = new JsonDocumentData();
			doc.setDocId(Integer.parseInt(String.valueOf(jsonRow.get("docId"))));
			doc.setEnvelopeId(String.valueOf(jsonRow.get("envelopeId")));
			doc.setDocumentName(String.valueOf(jsonRow.get("documentName")));
			doc.setCompletedDate(String
					.valueOf(jsonRow.get("completedDate") == null ? "" : String.valueOf(jsonRow.get("completedDate"))));
			doc.setStatus(String.valueOf(jsonRow.get("status")));
			doc.setSignType(String.valueOf(jsonRow.get("signType")));
			docList.add(doc);
		}
		return docList;
	}

	@Override
	public Draft getDocumentDraft(int docId) throws DaoException {
		String sql = queryProps.getProperty("getDocumentDraft");
		try {
			Draft d = jdbcTemplate.query(sql, new Object[] { docId }, new ResultSetExtractor<Draft>() {
				public Draft extractData(ResultSet rs) throws SQLException, DataAccessException {
					if (rs.next()) {
						Draft draft = new Draft();
						draft.setDraftId(rs.getInt("id"));
						draft.setDocId(rs.getInt("doc_id"));
						draft.setUrl(rs.getString("url"));
						draft.setStepNumber(rs.getInt("step"));
						draft.setIncrement(rs.getInt("increment"));
						return draft;
					}
					return null;
				}
			});
			// logger.info("exit from "+classMethod);
			return d;

		} catch (Exception e) {
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public String saveSetting(String project, String theme) {

		String sql = queryProps.getProperty("savesettings");

		Object[] args = new Object[] { project, theme };

		int out = jdbcTemplate.update(sql, args);
		if (out != 0) {
			logger.info("Project updated with name=" + project);
			logger.info("theme updated with name=" + theme);
			logger.info("[End] saveSetting");

			return SUCCESS;
		}
		logger.info("problem with project name =" + project);
		return FAILURE;
	}

	@Override
	public DocumentCount getDocumentCount(int id) throws DaoException {
		// TODO Auto-generated method stub
		String classMethod = className + ":  getDocumentCount";
		logger.info(String.format("enter into " + classMethod + "(id = %s)", id));
		String sql = queryProps.getProperty("documentCountApp");

		try {
			DocumentCount user = jdbcTemplate.query(sql, new Object[] { id, id, id, id, id, id },
					new ResultSetExtractor<DocumentCount>() {
						public DocumentCount extractData(ResultSet rs) throws SQLException, DataAccessException {
							DocumentCount r = new DocumentCount();
							if (rs.next()) {
								r.setCompleted(rs.getInt("completed"));
								r.setDraft(rs.getInt("draft"));
								r.setOutForSignature(rs.getInt("outForSignature"));
								r.setDeleted(rs.getInt("deleted"));
								r.setTotal(rs.getInt("totalDocument"));

								return r;
							}
							return r;
						}
					});
			logger.info("exit from " + classMethod);
			return user;

		} catch (Exception e) {
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public int saveSignature(final int id, final String dataURL,final String signType ) {
		// TODO Auto-generated method stub
		int signerId = 0;
		String updateSql = queryProps.getProperty("updateInsertSignApp");
		String selectSql = queryProps.getProperty("getInsertSignApp");
		KeyHolder keyHolder = new GeneratedKeyHolder();
		List<Integer> ids = jdbcTemplate.queryForList(selectSql, Integer.class, id);

		int flag = 0;
		for (Integer i : ids) {
			Object[] args = new Object[] { flag, i };

			int out = jdbcTemplate.update(updateSql, args);
			if (out != 0) {
				logger.info("draft updated with id=" + i);

			}
		}

		final String insertSql = queryProps.getProperty("addInsertSignApp");
		jdbcTemplate.update(new PreparedStatementCreator() {
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pst = con.prepareStatement(insertSql, new String[] { "id" });
				int index = 1;
				pst.setInt(index++, id);
				pst.setString(index++, dataURL);
				pst.setTimestamp(index++, CommonUtils.currentDate());
				pst.setInt(index++, 1);
				pst.setString(index++, signType);
				return pst;
			}
		}, keyHolder);
		signerId = Integer.parseInt(keyHolder.getKey().toString());

		return signerId;
	}

	@Override
	public int savePhoto(final int id, final String dataURL) {
		// TODO Auto-generated method stub
		int signerId = 0;
		String updateSql = queryProps.getProperty("updateInsertPhotoApp");
		String selectSql = queryProps.getProperty("getInsertPhotoApp");
		KeyHolder keyHolder = new GeneratedKeyHolder();
		List<Integer> ids = jdbcTemplate.queryForList(selectSql, Integer.class, id);

		int flag = 0;
		for (Integer i : ids) {
			Object[] args = new Object[] { flag, i };

			int out = jdbcTemplate.update(updateSql, args);
			if (out != 0) {
				logger.info("draft updated with id=" + i);

			}
		}
		final String insertSql = queryProps.getProperty("addInsertPhotoApp");
		jdbcTemplate.update(new PreparedStatementCreator() {
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pst = con.prepareStatement(insertSql, new String[] { "id" });
				int index = 1;
				pst.setInt(index++, id);
				pst.setString(index++, dataURL);
				pst.setTimestamp(index++, CommonUtils.currentDate());
				pst.setInt(index++, 1);

				return pst;
			}
		}, keyHolder);
		signerId = Integer.parseInt(keyHolder.getKey().toString());
		return signerId;
	}

	@Override
	public ApplicationDocument getSignature(int id, int flag) throws DaoException {
		// TODO Auto-generated method stub
		String selectSql = queryProps.getProperty("getSignature");
	
		try {
			ApplicationDocument ad = jdbcTemplate.query(selectSql, new Object[] { id,flag},
					new ResultSetExtractor<ApplicationDocument>() {
						public ApplicationDocument extractData(ResultSet rs) throws SQLException, DataAccessException {
							ApplicationDocument r = new ApplicationDocument();
							if (rs.next()) {
								r.setDataURL(rs.getString("signature_data"));
								r.setSignType(rs.getString("sign_type"));
								return r;
							}
							return r;
						}
					});
			return ad;

		} catch (Exception e) {
			throw new DaoException(e.getMessage());
		}

	}

	@Override
	public int getDocumentId(String envelopeId, int userId) {
		// TODO Auto-generated method stub
		String selectSql = queryProps.getProperty("getDocumentId");
		int docId=0;
		List<Integer> documentId = jdbcTemplate.queryForList(selectSql, Integer.class, envelopeId,userId);
		if(!documentId.isEmpty()){
			docId=documentId.get(0);
		}else{
			docId=0;
		}
		return docId;
	}

	@Override
	public String saveTempSigner(final List<DocumentField> documentField) {
		// TODO Auto-generated method stub
		
		String query = queryProps.getProperty("deleteTempSigner");

		Object[] args = new Object[] { documentField.get(0).getDocId() };

		int out = jdbcTemplate.update(query, args);
		if (out != 0) {
			logger.info("document updated with id=" + documentField.get(0).getDocId());
		}
		
		int[] updateCnt = null;
		try {
			updateCnt = jdbcTemplate.batchUpdate(queryProps.getProperty("saveTempSigner"),
					new BatchPreparedStatementSetter() {
						public void setValues(PreparedStatement ps, int i) throws SQLException {
							ps.setInt(1, documentField.get(i).getDocId());
							ps.setInt(2, documentField.get(i).getDraftId());
							ps.setInt(3, documentField.get(i).getPriority());
							ps.setString(4, documentField.get(i).getSignerName());
							ps.setString(5, documentField.get(i).getSignerEmail());
							ps.setString(6, documentField.get(i).getFlag());
						}
						public int getBatchSize() {
							return documentField.size();
						}
					});

		} catch (Exception e) {
			logger.info("Problem while updating document fields " + e.getMessage());
			e.printStackTrace();
		}
		if (updateCnt.length > 0) {
			logger.info("document field insertion success");
			return SUCCESS;
		}
		logger.info("document field insertion failure");
		return FAILURE;
	}

	@Override
	public List<DocumentField> getTempSigner(int docId) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("getTempSigner");
		List<DocumentField> docList = new ArrayList<DocumentField>();
		List<Map<String, Object>> jsonRows = jdbcTemplate.queryForList(query, new Object[] { docId });
		for (Map<String, Object> jsonRow : jsonRows) {
			DocumentField doc = new DocumentField();
			doc.setDocId(Integer.parseInt(String.valueOf(jsonRow.get("docId"))));
			doc.setDraftId(Integer.parseInt(String.valueOf(jsonRow.get("draftId"))));;
			doc.setPriority(Integer.parseInt(String.valueOf(jsonRow.get("priority"))));;
			doc.setSignerName(String.valueOf(jsonRow.get("signerName")));
			doc.setSignerEmail(String.valueOf(jsonRow.get("signerEmail")));
			doc.setFlag(String.valueOf(jsonRow.get("flag")));
			docList.add(doc);
		}
		return docList;
	}

	@Override
	public String saveGroupSignFields(List<DocumentField> documentField) {
		// TODO Auto-generated method stub
		int status = 0;
		int docStatus=102; //outforsgnature
		String msg = "success";
		//save document subject and message
		String documentSignInsertSql =queryProps.getProperty("documentSignInsert-SqlCreateGroupSign");
		try {
			status = jdbcTemplate.update(documentSignInsertSql, documentField.get(0).getSubject(), documentField.get(0).getMessage(),documentField.get(0).getCc()==""?null:documentField.get(0).getCc(),
					docStatus,documentField.get(0).getDocId());
			if(status ==1)
			{
				//save document fields
				msg= saveDocumentFields(documentField);
				if(msg == "SUCCESS"){
					msg ="success";
				}
			}
		} catch (Exception e) {
			msg = e.getMessage();
		}
		return msg;
	}

	@Override
	public int saveGroupSigner(final Signer signer) {
		
		KeyHolder keyHolder = new GeneratedKeyHolder();
		final String sql = queryProps.getProperty("saveGroupSigner");
			if(signer.getSignerName() !=null && signer.getSignerEmail() !=null && signer.getSignerName() !="" && signer.getSignerEmail() !=""){
				jdbcTemplate.update(new PreparedStatementCreator() {
					public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
						PreparedStatement pst = con.prepareStatement(sql, new String[] { "id" });
						int index = 1;
						pst.setString(index++, signer.getSignerName());
						pst.setString(index++, signer.getSignerEmail());
						pst.setInt(index++, 0);
						pst.setInt(index++, 0);
						pst.setInt(index++, signer.getUserId());
						pst.setString(index++, signer.getSignerUrl());
						pst.setTimestamp(index++, CommonUtils.currentDate());
						pst.setInt(index++, signer.getDocId());
						return pst;
					}
				}, keyHolder);
			}	
	    return Integer.parseInt(keyHolder.getKey().toString());
	}

	@Override
	public String getSignerToken(int signerId) {
		// TODO Auto-generated method stub
		String selectSql = queryProps.getProperty("getSignerToken");
		String signerToken=null;
		List<String> token = jdbcTemplate.queryForList(selectSql, String.class, signerId);
		if(!token.isEmpty()){
			signerToken=token.get(0);
		}else{
			signerToken="";
		}
		return signerToken;
	}

	@Override
	public SignerData checkValidSigneKey(String key) throws DaoException {
		// TODO Auto-generated method stub
		String sql = queryProps.getProperty("checkValidSigneKey");
		try {
			SignerData signer = jdbcTemplate.query(sql, new Object[] { key },
					new ResultSetExtractor<SignerData>() {
						public SignerData extractData(ResultSet rs) throws SQLException, DataAccessException {
							SignerData s = new SignerData();
							if (rs.next()) {
								s.setSignerId(rs.getInt("signerId"));
								s.setDocId(rs.getInt("docId"));
								s.setSignStatus(rs.getInt("status"));
								s.setSignType(rs.getString("signType"));
								s.setRequestBy(rs.getInt("requestedBy"));
								s.setSignerEmail(rs.getString("signerEmail"));
								s.setPriority(rs.getInt("priority"));
								s.setRequestName(rs.getString("requestName"));
								s.setRequestEmail(rs.getString("requestEmail"));
								s.setProjectName(rs.getString("projectName"));
								s.setSignerName(rs.getString("signerName"));
								s.setDocStatus(rs.getString("docStatus"));
								
								return s;
							}
							return s;
						}
					});
			
			return signer;

		} catch (Exception e) {
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public List<DocumentField> getApplicationFieldData(String documentName, String fileid, String signeremail)
			throws DaoException {
		// TODO Auto-generated method stub
		//String query_partyId = "select f.id,f.form_field_name,f.form_field_type,f.pageno,f.y_position,f.x_position,f.height,f.width from tb_document_details as doc INNER JOIN documents_fields As f  on doc.id=f.document_id where document_name =?";
		String sql = queryProps.getProperty("getApplicationApp");     
		List<DocumentField> dfList = new ArrayList<DocumentField>();
		try{ 
        List<Map<String,Object>> dfRows = jdbcTemplate.queryForList(sql,new Object[]{signeremail,fileid});
         
        for(Map<String,Object> df : dfRows){
        	DocumentField fields = new DocumentField();
        	
        	fields.setId((Integer.parseInt((String.valueOf(df.get("id"))))));
        	fields.setFieldName(String.valueOf(df.get("field_name")));
        	if(df.get("field_value") != null || df.get("field_value") != ""){
        		fields.setFieldValue(String.valueOf(df.get("field_value")));
        	}
        	fields.setFieldType(String.valueOf(df.get("field_type")));
        	fields.setPageNumber(Integer.parseInt((String.valueOf(df.get("page_number")))));
        	fields.setFieldWidth(Float.parseFloat((String.valueOf(df.get("width")))));
        	fields.setFieldHeight(Float.parseFloat((String.valueOf(df.get("height")))));
        	fields.setxPosition(Float.parseFloat((String.valueOf(df.get("position_left")))));
        	fields.setyPosition(Float.parseFloat((String.valueOf(df.get("position_top")))));
        	dfList.add(fields);

        }
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
		
        return dfList;
	}

	@Override
	public List<JsonDocumentData> outForSignature(int userId) {
		// TODO Auto-generated method stub
		String sql = queryProps.getProperty("outForSignature");
		String sql1 = queryProps.getProperty("outForSignaturePriority");
		List<JsonDocumentData> docList = new ArrayList<JsonDocumentData>();
		List<Map<String, Object>> jsonRows = jdbcTemplate.queryForList(sql, new Object[] { userId });
		for (Map<String, Object> jsonRow : jsonRows) {
			JsonDocumentData doc = new JsonDocumentData();
			doc.setDocId(Integer.parseInt(String.valueOf(jsonRow.get("docId"))));
			doc.setEnvelopeId(String.valueOf(jsonRow.get("envelopeId")));
			doc.setDocumentName(String.valueOf(jsonRow.get("documentName")));
			doc.setSubject(String.valueOf(jsonRow.get("subject")));
			doc.setMessage(String.valueOf(jsonRow.get("message")));
			doc.setRequestedBy(String.valueOf(jsonRow.get("requestedBy")));
			doc.setUploadDate((String.valueOf(jsonRow.get("uploadDate"))));
			doc.setStatus(String.valueOf(jsonRow.get("status")));
			doc.setSignType(String.valueOf(jsonRow.get("signType")));
			docList.add(doc);
		}
		for (JsonDocumentData jd : docList) {
			int docId = jd.getDocId();
			List<Map<String, Object>> sRows = jdbcTemplate.queryForList(sql1, new Object[] { docId });
			List<String> signerIdList = new ArrayList<String>();
			List<String> signerNameList = new ArrayList<String>();
			List<String> signerStatusList = new ArrayList<String>();
			List<String> priorityList = new ArrayList<String>();
			List<String> emailCountList = new ArrayList<String>();
			List<String> emailIDList = new ArrayList<String>();
			//int count = 1;
			for (Map<String, Object> sRow : sRows) {
				signerIdList.add(String.valueOf(sRow.get("signerId")));
				signerNameList.add(String.valueOf(sRow.get("signerName")));
				signerStatusList.add(String.valueOf(sRow.get("signerStatus")));
				String priority = String.valueOf(sRow.get("priority"));
				/*if (priority.equals("0")) {
					count += 0;
				}*/
				priorityList.add(priority);
				//count++;
				/*emailCountList.add((String.valueOf(sRow.get("emailCount"))));
*/				emailIDList.add((String.valueOf(sRow.get("signerEmailId"))));
			}
			jd.setSignerId(StringUtils.join(signerIdList, ','));
			jd.setSignerName(StringUtils.join(signerNameList, ','));
			jd.setSignerStatus(StringUtils.join(signerStatusList, ','));
			jd.setPriority(StringUtils.join(priorityList, ','));
			jd.setEmailCount(StringUtils.join(emailCountList, ','));
			jd.setSignerEmailId(StringUtils.join(emailIDList, ','));
		}
		return docList;
	}

	@Override
	public String updateSignerFields(final List<DocumentField> documentField) {
		// TODO Auto-generated method stub
		int[] updateCnt = null;
		try {
			updateCnt = jdbcTemplate.batchUpdate(queryProps.getProperty("updateSignerFields"),
					new BatchPreparedStatementSetter() {
						public void setValues(PreparedStatement ps, int i) throws SQLException {
							ps.setString(1, documentField.get(i).getFieldValue());
							ps.setInt(2, documentField.get(i).getId());
						}
						public int getBatchSize() {
							return documentField.size();
						}
					});

		} catch (Exception e) {
			logger.info("Problem while updating document fields " + e.getMessage());
			e.printStackTrace();
		}
		if (updateCnt.length > 0) {
			logger.info("document field insertion success");
			return SUCCESS;
		}
		logger.info("document field insertion failure");
		return FAILURE;
	}

	@Override
	public boolean getAllSignerStatus(int docId, int signerId) {
		// TODO Auto-generated method stub
		List<String> oldList=new ArrayList<>();
		oldList.add("1");
		
		String query = queryProps.getProperty("getAllSignerStatus");
		List<String> newList = new ArrayList<String>();
		List<Map<String, Object>> jsonRows = jdbcTemplate.queryForList(query, new Object[] { docId });
		for (Map<String, Object> jsonRow : jsonRows) {
			String status=String.valueOf(jsonRow.get("signerStatus"));
			newList.add(status);
		}
		LinkedHashSet<String> s = new LinkedHashSet<String>();
		s.addAll(newList);
		
		List<String> fList=new ArrayList<>();
		
		fList.addAll(s);
		boolean x=CommonUtils.equalLists(oldList,fList);
		
		return x;
	}

	@Override
	public String updateSignerStatus(int signerId, String signDocId, int signerStatus) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("updateSignerStatus");
		Object[] args = new Object[] { signDocId, signerStatus,signerId};
		int out = jdbcTemplate.update(query, args);
		if (out != 0) {
				return SUCCESS;
		}
		return FAILURE;
	}

	@Override
	public Signer nextSignerData(int docId, int priority) throws DaoException {
		// TODO Auto-generated method stub
		String sql = queryProps.getProperty("nextSignerData");
		try {
			Signer signer = jdbcTemplate.query(sql, new Object[] { docId,priority },
					new ResultSetExtractor<Signer>() {
						public Signer extractData(ResultSet rs) throws SQLException, DataAccessException {
							Signer s = new Signer();
							if (rs.next()) {
								s.setSignerEmail(rs.getString("signerEmail"));
								s.setSignerName(rs.getString("signerName"));
								s.setSignStatus(rs.getInt("signStatus"));
								s.setSignerUrl(rs.getString("signerUrl"));
							  return s;
							}
							return s;
						}
					});
			
			return signer;

		} catch (Exception e) {
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public String getPic(int id, int flag) {
		String selectSql = queryProps.getProperty("getPic");
		String mypic=null;
		List<String> pic = jdbcTemplate.queryForList(selectSql, String.class, id,flag);
		if(!pic.isEmpty()){
			mypic=pic.get(0);
		}else{
			mypic=null;
		}
		return mypic;
	}

	@Override
	public Document checkValidPrepareKey(String key) throws DaoException {
		// TODO Auto-generated method stub
		String sql = queryProps.getProperty("checkValidPrepareKey");
		try {
			Document doc = jdbcTemplate.query(sql, new Object[] { key },
					new ResultSetExtractor<Document>() {
						public Document extractData(ResultSet rs) throws SQLException, DataAccessException {
							Document d = new Document();
							if (rs.next()) {
								d.setDocStatus(rs.getString("docStatus"));
								d.setId(rs.getInt("docId"));
								d.setUserId(rs.getInt("userId"));
								d.setPrepareReturnURL(rs.getString("prepareReturnURL"));
								return d;
							}
							return d;
						}
					});
			return doc;

		} catch (Exception e) {
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public List<Signer> getSignerList(int docId) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("getSignerList");
		List<Signer> signerList = new ArrayList<Signer>();
		List<Map<String, Object>> jsonRows = jdbcTemplate.queryForList(query, new Object[] { docId });
		for (Map<String, Object> jsonRow : jsonRows) {
			Signer s = new Signer();
			s.setPriority(Integer.parseInt(String.valueOf(jsonRow.get("priority"))));
			s.setSignerId(Integer.parseInt(String.valueOf(jsonRow.get("signerId"))));
			s.setSignerName(String.valueOf(jsonRow.get("signerName")));
			s.setSignerEmail(String.valueOf(jsonRow.get("signerEmail")));
			signerList.add(s);
		}
		return signerList;
	}
	
	@Override
	public List<Signer> getSignerList1(int docId) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("getSignerList1");
		List<Signer> signerList = new ArrayList<Signer>();
		List<Map<String, Object>> jsonRows = jdbcTemplate.queryForList(query, new Object[] { docId });
		for (Map<String, Object> jsonRow : jsonRows) {
			Signer s = new Signer();
			s.setSignerId(Integer.parseInt(String.valueOf(jsonRow.get("signerId"))));
			s.setSignerName(String.valueOf(jsonRow.get("signerName")));
			s.setSignerEmail(String.valueOf(jsonRow.get("signerEmail")));
			signerList.add(s);
		}
		return signerList;
	}

	@Override
	public ApplicationDocument getDocumentByEnvelopeId(String envelopeId) throws DaoException {
		// TODO Auto-generated method stub
		String classMethod = className + ":  getDocumentByEnvelopeId";
		logger.info(String.format("Enter into " + classMethod + "(envelopeId = %s)", envelopeId));
		String sql = queryProps.getProperty("getDocumentByEnvelopeId");

		try {
			ApplicationDocument document = jdbcTemplate.query(sql, new Object[] { envelopeId },
					new ResultSetExtractor<ApplicationDocument>() {
						public ApplicationDocument extractData(ResultSet rs) throws SQLException, DataAccessException {
							if (rs.next()) {
								ApplicationDocument doc = new ApplicationDocument();
								doc.setId(rs.getInt("id"));
								doc.setUserId(rs.getInt("user_id"));
								doc.setSignType(rs.getString("sign_type"));
								doc.setEnvelopeId(rs.getString("envelopeid"));
								doc.setFileName(rs.getString("name"));
								doc.setOriginalId(rs.getString("original_doc_id"));
								doc.setElectronicId(rs.getString("electronic_doc_id"));
								doc.setDigitalld(rs.getString("digital_doc_id"));
								doc.setOriginal(rs.getBlob("original") == null ? null
										: rs.getBlob("original").getBinaryStream());
								doc.setElectronic(rs.getBlob("electronic") == null ? null
										: rs.getBlob("electronic").getBinaryStream());
								doc.setDigital(
										rs.getBlob("digital") == null ? null : rs.getBlob("digital").getBinaryStream());
								doc.setDocStatus(rs.getString("doc_status"));
								doc.setSubject(rs.getString("subject"));
								doc.setMessage(rs.getString("message"));
								doc.setCc(rs.getString("cc"));
								doc.setDocUrl(rs.getString("doc_url"));
								return doc;
							}
							return null;
						}
					});
			logger.info("exit from " + classMethod);
			return document;

		} catch (Exception e) {
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public Signature getSignature(String token,String email) throws DaoException {
		// TODO Auto-generated method stub
		String sql = queryProps.getProperty("getUserSignatureByToken");
		String sql1 = queryProps.getProperty("getUserSignatureByEmail");
		if(token != null){
			try {
				Signature signture = jdbcTemplate.query(sql, new Object[] { token},
						new ResultSetExtractor<Signature>() {
							public Signature extractData(ResultSet rs) throws SQLException, DataAccessException {
								Signature s = new Signature();
								if (rs.next()) {
									s.setId(rs.getInt("id"));
									s.setFirstName(rs.getString("firstName"));
									s.setLastName(rs.getString("lastName"));
									s.setEmail(rs.getString("email"));
									s.setSignature(rs.getString("signature"));
									s.setStatus(rs.getInt("status"));
									s.setSignType(rs.getString("signType"));
								  return s;
								}
								return null;
							}
						});
				
				return signture;
	
			} catch (Exception e) {
				throw new DaoException(e.getMessage());
			}
		}else{
			try {
				Signature signture = jdbcTemplate.query(sql1, new Object[] { email},
						new ResultSetExtractor<Signature>() {
							public Signature extractData(ResultSet rs) throws SQLException, DataAccessException {
								Signature s = new Signature();
								if (rs.next()) {
									s.setId(rs.getInt("id"));
									s.setFirstName(rs.getString("firstName"));
									s.setLastName(rs.getString("lastName"));
									s.setEmail(rs.getString("email"));
									s.setSignature(rs.getString("signature"));
									s.setStatus(rs.getInt("status"));
								  return s;
								}
								return null;
							}
						});
				
				return signture;
	
			} catch (Exception e) {
				throw new DaoException(e.getMessage());
			}
		}
	}

	@Override
	public String saveUserSignature(Signature userSignature) throws DaoException {
		// TODO Auto-generated method stub
		Signature signature=getSignature(userSignature.getToken(),userSignature.getEmail());
		if(signature !=null){
			String query = queryProps.getProperty("updateUserSignature");
			Object[] args = new Object[] { userSignature.getSignature(),1,userSignature.getSignType(),CommonUtils.currentDate(),userSignature.getEmail()};
			int out = jdbcTemplate.update(query, args);
			if (out != 0) {
					return SUCCESS;
			}
			return FAILURE;
		}else{
			String uniqueID = new GlobalFunctions().uniqueToken();
			userSignature.setToken(uniqueID);
			String query = queryProps.getProperty("saveUserSignature");
			Object[] args = new Object[] {userSignature.getFirstName(),userSignature.getLastName(),userSignature.getEmail(),userSignature.getSignature(),userSignature.getToken(),userSignature.getStatus(),CommonUtils.currentDate(),userSignature.getSignType()};
			int out = jdbcTemplate.update(query, args);
			if (out != 0) {
					return SUCCESS;
			}
			return FAILURE;
		}
	}

	@Override
	public String updateSignerEmail(String signerName,String token,int signerId,String newEmail,int docId){
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("updateSignerEmail");
		Object[] args = new Object[] {signerName,token,newEmail,signerId};
		int out = jdbcTemplate.update(query, args);
		if (out != 0) {
				return SUCCESS;
		}
		return FAILURE;
	}

	@Override
	public String removeSigner(int docId, int signerId) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("removeSigner");
		Object[] args = new Object[] {signerId,docId};
		int out = jdbcTemplate.update(query, args);
		if (out != 0) {
				return SUCCESS;
		}
		return FAILURE;
	}

	@Override
	public String updateSignerPriority(Signer signer) {
		// TODO Auto-generated method stub
		
		String query = queryProps.getProperty("updateSignerPriority");
		Object[] args = new Object[] {signer.getPriority(),signer.getSignerId(),signer.getDocId()};
		int out = jdbcTemplate.update(query, args);
		if (out != 0) {
			return SUCCESS;
		}
		return FAILURE;
	}
}
