CREATE TABLE document (
  id int IDENTITY(1,1),
  user_id int NOT NULL,
  envelopeid varchar(255) DEFAULT NULL,
  name varchar(250) NOT NULL,
  original varbinary(Max) ,
  electronic varbinary(Max) ,
  digital varbinary (Max),
  status tinyint NOT NULL,
  file_type char(1) DEFAULT NULL,
  subject varchar(255) DEFAULT NULL,
  message text,
  sign_type char(1) DEFAULT NULL,
  upload_date datetime DEFAULT NULL,
  complete_date datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ;

CREATE TABLE document_sign_email (
  id int IDENTITY(1,1),
  signer_id int DEFAULT NULL,
  document_id int DEFAULT NULL,
  priority int DEFAULT NULL,
  sent_email_count int DEFAULT NULL,
  token varchar(255) DEFAULT NULL,
  status tinyint NOT NULL,
  created_date datetime NOT NULL,
  PRIMARY KEY (id)
) ;

CREATE TABLE document_sign_field (
  id int IDENTITY(1,1),
  signer_id int DEFAULT NULL,
  document_id int DEFAULT NULL,
  page_number int DEFAULT NULL,
  priority int DEFAULT NULL,
  position_left varchar(50) DEFAULT NULL,
  position_top varchar(50) DEFAULT NULL,
  height varchar(50) DEFAULT NULL,
  width varchar(50) DEFAULT NULL,
  field_value varchar(max),
  field_name varchar(50) DEFAULT NULL,
  field_type varchar(50) DEFAULT NULL,
  created_date datetime NOT NULL,
  PRIMARY KEY (id)
) ;


CREATE TABLE signature (
  id int IDENTITY(1,1),
  user_id int ,
  signature_data VARCHAR(MAX),
  created_date datetime,
  PRIMARY KEY (id)
) ;


CREATE TABLE signer (
  id int IDENTITY(1,1),
  name varchar(250) NOT NULL,
  email varchar(250) NOT NULL,
  user_type tinyint NOT NULL ,
  status tinyint NOT NULL,
  created_on datetime,
  updated_on datetime ,
  PRIMARY KEY (id)
) ;



CREATE TABLE token_details (
  id int IDENTITY(1,1),
  user_id int NOT NULL,
  token varchar(250) NOT NULL,
  status tinyint NOT NULL,
  valid_from datetime NOT NULL,
  valid_to datetime NOT NULL,
  PRIMARY KEY (id)
) ;

CREATE TABLE users (
  id int IDENTITY(1,1),
  firstname varchar(250) NOT NULL,
  lastname varchar(255) DEFAULT NULL,
  photo varchar(255) DEFAULT NULL,
  email varchar(250) NOT NULL,
  phone varchar(250) DEFAULT NULL,
  country varchar(250) DEFAULT NULL,
  state varchar(250) DEFAULT NULL,
  pincode varchar(250) DEFAULT NULL,
  password varchar(250) DEFAULT NULL,
  company_name varchar(250) DEFAULT NULL,
  job_title varchar(250) DEFAULT NULL,
  client_id varchar(250) DEFAULT NULL,
  client_secret varchar(250) DEFAULT NULL,
  email_verification_token varchar(250) DEFAULT NULL,
  user_type tinyint NOT NULL,
  status tinyint NOT NULL,
  role varchar(250) DEFAULT NULL,
  is_company varchar(5) DEFAULT 'No',
  created_on datetime NOT NULL,
  updated_on datetime DEFAULT NULL ,
  project_name varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
) ;

CREATE TABLE user_forgot_password (
  id int IDENTITY(1,1),
  user_id int NOT NULL,
  token varchar(250) DEFAULT NULL,
  status tinyint NOT NULL,
  date datetime NOT NULL,
  PRIMARY KEY (id)
) ;


CREATE TABLE token_details (
  id int NOT NULL IDENTITY(1,1),
  user_id int NOT NULL,
  token varchar(250) NOT NULL,
  status tinyint NOT NULL,
  valid_from datetime NOT NULL,
  valid_to datetime NOT NULL,
  PRIMARY KEY (id)
) ;


ALTER TABLE users
ADD theme varchar(20)

ALTER TABLE users
ADD drysignlink varchar(10)

ALTER TABLE users
ADD deviceversion varchar(10)

ALTER TABLE users ALTER COLUMN firstname varchar(255)  NULL

CREATE TABLE audit (
  id int IDENTITY(1,1),
  userid int FOREIGN KEY REFERENCES users(id),
  ip_address varchar(250) NOT NULL,
  web_request nvarchar(max) NOT NULL ,
  web_response nvarchar(max) NOT NULL,
  method_name varchar(255) NOT NULL,
  status varchar(250) NOT NULL,
  created_on datetime NOT NULL,
  updated_on datetime
  PRIMARY KEY (id)
) ;


/**CRETAE ROLE ADMIN SCRIPT **/
INSERT INTO users(
firstname,
lastname,
email,
phone,
country,
state,
pincode,
email_verification_token,
user_type,
status,
role,
created_on,
password
)
values(
'admin',
'dryadmin',
'admin@drysign.me',
'9819230987',
'India',
'Maharashtra',
'411016',
'78588e7f-80e7-4578-b2ff-2d8fe307c56d',
3,
1,
'ROLE_ADMIN',
getdate(),
'$2a$10$vN8pxQtcU5mCP7Zr1mYlqe/37FmZDZXOMA6qm9n/afo6dO4sXSjnu'
);




ALTER TABLE document
ADD client_ip_address varchar(50)


/*start subscription schema*/

CREATE TABLE subscription_plan (
  plan_id int IDENTITY(1,1),
  currency varchar(50),
  amount varchar(50),
  plan_name varchar(255),
  no_of_days varchar(255) DEFAULT NULL,
  no_of_documents varchar(250) NOT NULL,
  status tinyint NOT NULL,
  content text,
  date datetime DEFAULT NULL,
  PRIMARY KEY (plan_id)
) ;

CREATE TABLE subscription (
  subscription_id int IDENTITY(1,1),
  user_id int,
  plan_id int,
  status tinyint ,
  subscription_start_date datetime DEFAULT NULL,
  subscription_end_date datetime DEFAULT NULL,
  PRIMARY KEY (subscription_id)
);

CREATE TABLE purchase (
  purchase_id int IDENTITY(1,1),
  subscription_id int,
  payment_method varchar(250),
  price varchar(250),
  status tinyint,
  date datetime DEFAULT NULL,
  PRIMARY KEY (purchase_id)
) ;

/*15-12-2016*/
CREATE TABLE subscription_plan_name (
  id int IDENTITY(1,1),
  plan_name varchar(250),
  date datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ;
insert into subscription_plan_name(plan_name) values('general-plans');
insert into subscription_plan_name(plan_name) values('api-plans');

drop table subscription_plan


CREATE TABLE subscription_plan (
  plan_id int IDENTITY(1,1),
  subscription_plan_name_id int,
  plan_identifier varchar(50),
  currency varchar(50),
  amount varchar(50),
  plan_name varchar(255),
  no_of_days varchar(255) DEFAULT NULL,
  no_of_documents varchar(250) NOT NULL,
  status tinyint NOT NULL,
  content text,
  date datetime DEFAULT NULL,
  PRIMARY KEY (plan_id)
) ;


USE [DrySign]
GO

/****** Object:  Table [dbo].[sb_subscription]    Script Date: 4/12/2017 1:01:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sb_subscription](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[plan_id] [int] NULL,
	[credited_documents] [int] NULL,
	[used_documents] [int] NULL,
	[status] [tinyint] NULL,
	[subscription_start_date] [datetime] NULL DEFAULT (NULL),
	[subscription_end_date] [datetime] NULL DEFAULT (NULL),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


==================================================================================================
USE [DrySign]
GO

/****** Object:  Table [dbo].[sb_purchase]    Script Date: 4/12/2017 1:01:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[sb_purchase](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subscription_id] [int] NULL,
	[plan_name] [varchar](250) NULL,
	[category_name] [varchar](250) NULL,
	[plan_price] [varchar](250) NULL,
	[currency] [varchar](250) NULL,
	[noofdays] [int] NULL,
	[noofdocs] [int] NULL,
	[noofusers] [int] NULL,
	[features] [varchar](250) NULL,
	[duration_name] [varchar](250) NULL,
	[duration_time] [varchar](250) NULL,
	[duration_unit] [varchar](250) NULL,
	[transaction_id] [varchar](250) NULL,
	[client_referid] [varchar](250) NULL,
	[payment_method] [varchar](250) NULL,
	[payment_method_response] [varchar](250) NULL,
	[status] [tinyint] NULL,
	[date] [datetime] NULL DEFAULT (NULL),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


/*insert subscription for talento*/

insert into sb_subscription
(user_id,plan_id,credited_documents,used_documents,status,subscription_start_date,subscription_end_date)
values(184,1,1000,0,1,'2017-04-24 13:34:35.730','2018-04-24 13:34:35.730')

insert into sb_purchase(subscription_id,plan_name,category_name,plan_price,currency,noofdays,noofdocs,noofusers,features,duration_name,duration_time,duration_unit,transaction_id,payment_method,payment_method_response,status,date,client_referid)
values('2216','INHOUSE PLAN','Internal uses',0,'USD',365,1000,1,'','yearly',365,'days','','','',1,'2017-04-20 13:34:35.730','')



/*end subscription schema*/

/***************EFA ******************/
ALTER TABLE Document
ADD original_doc_id varchar(255)

ALTER TABLE Document
ADD electronic_doc_id varchar(255)

ALTER TABLE Document
ADD digital_doc_id varchar(255)

/************release 1.2.0*****************/
ALTER TABLE users
ADD mobile varchar(20)

ALTER TABLE users
ADD city varchar(20)

ALTER TABLE users
ADD address varchar(250)


ALTER TABLE document
ADD doc_status int

CREATE TABLE draft (
  id int IDENTITY(1,1),
  doc_id int ,
  url VARCHAR(MAX),
  step int
  PRIMARY KEY (id)
) ;

create table email_notification(
	id int IDENTITY(1,1),
	doc_id int NOT NULL,
	user_id int NOT NULL,
	subject varchar(max) NOT NULL,
	messgae varchar(max) NOT NULL,
	from_email  varchar(255) NOT NULL,
	to_email varchar(max) NOT NULL,
	cc varchar(max) DEFAULT NULL,
	bcc  varchar(max) DEFAULT NULL,
	status  varchar(10) NOT NULL,
	reason  varchar(max) NOT NULL,
	created_on datetime NOT NULL,
	PRIMARY KEY (id)
)


ALTER TABLE signature
ADD flag tinyint 

CREATE TABLE photo (
  id int IDENTITY(1,1),
  user_id int ,
  photo_data VARCHAR(MAX),
  created_date datetime,
  PRIMARY KEY (id)
) ;

ALTER TABLE photo
ADD flag tinyint 

ALTER TABLE draft
ADD increment int


ALTER TABLE draft
ADD priority int

ALTER TABLE draft
ADD signer_name varchar(255)

ALTER TABLE draft
ADD signer_email varchar(255);

CREATE TABLE tempSigner (
  id int IDENTITY(1,1),
  doc_id int,
  draft_id int,
  priority int,
  name varchar(250),
  email varchar(250),
  
  PRIMARY KEY (id)
) ;

ALTER TABLE tempSigner
ADD flag varchar(255);

ALTER TABLE signer
ADD user_id int;

ALTER TABLE signer
ADD signer_doc_id varchar(255);

ALTER TABLE signer
ADD sign_url varchar(255);

ALTER TABLE Document
ADD cc varchar(255)

/******/
	ALTER TABLE signature
	ADD sign_type varchar(255)

ALTER TABLE document
ADD doc_url varchar(max)

ALTER TABLE document
ADD prepare_doc_url varchar(max)


/*start global webservice api development*/
ALTER TABLE signer ADD doc_id int;
ALTER TABLE document ADD prepare_return_url varchar(max)

/*email alerts 7/20/2017*/
ALTER TABLE users ADD emailalert int NOT NULL DEFAULT(1)

CREATE TABLE tbmst_signer_sign (
  id int IDENTITY(1,1),
  firstname varchar(255) DEFAULT NULL,
  lastname varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  signature text,
  token varchar(255) NOT NULL,
  status tinyint NOT NULL,/*1=>active,0=>de-active*/
  created_date datetime DEFAULT NULL,
  updated_date datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ;


/******add sign type**************/
ALTER TABLE tbmst_signer_sign
ADD sign_type varchar(255)
