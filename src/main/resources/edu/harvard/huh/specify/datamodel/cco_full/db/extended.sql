-- liquibase formatted sql
-- accession
-- agent
-- attachment
-- collectingeventattachment
-- collectingevent
-- collectionobjectattachment
-- collectionobjectattribute
-- collection
-- collector
-- determination -> identification
-- geographytreedefitem
-- geography
-- geologictimeperiod
-- lithostrat -> wrapped into geologictimeperiod
-- locality
-- paleocontext
-- picklistitem
-- picklist
-- preptype -> use picklist/picklist item instead, removes support for loanable flag
-- preparationattachment
-- preparation
-- storage
-- taxon





--
-- Table structure for table agent
--

DROP TABLE IF EXISTS agent;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE agent (
  AgentID int(11) NOT NULL AUTO_INCREMENT,
  Abbreviation varchar(50) DEFAULT NULL,
  AgentType tinyint(4) NOT NULL,
  DateOfBirth date DEFAULT NULL,
  DateOfBirthPrecision tinyint(4) DEFAULT NULL,
  DateOfDeath date DEFAULT NULL,
  DateOfDeathPrecision tinyint(4) DEFAULT NULL,
  DateType tinyint(4) DEFAULT NULL,
  Email varchar(50) DEFAULT NULL,
  FirstName varchar(50) DEFAULT NULL,
  GUID varchar(128) DEFAULT NULL,
  Initials varchar(8) DEFAULT NULL,
  Interests varchar(255) DEFAULT NULL,
  JobTitle varchar(50) DEFAULT NULL,
  LastName varchar(120) DEFAULT NULL,
  MiddleInitial varchar(50) DEFAULT NULL,
  Remarks text,
  Suffix varchar(50) DEFAULT NULL,
  Title varchar(50) DEFAULT NULL,
  URL varchar(1024) DEFAULT NULL,
  InstitutionCCID int(11) DEFAULT NULL,
  InstitutionTCID int(11) DEFAULT NULL,
  
  SpecifyUserID int(11) DEFAULT NULL,
  CollectionTCID int(11) DEFAULT NULL,
  ParentOrganizationID int(11) DEFAULT NULL,
  
  CollectionCCID int(11) DEFAULT NULL,
  DivisionID int(11) DEFAULT NULL,
  PRIMARY KEY (AgentID),
  KEY AgentLastNameIDX (LastName),
  KEY AgentFirstNameIDX (FirstName),
  KEY AbbreviationIDX (Abbreviation),
  KEY AgentTypeIDX (AgentType),
  KEY AgentGuidIDX (GUID),
  KEY FK58743057699B003 (CreatedByAgentID),
  KEY FK587430587F159B7 (InstitutionTCID),
  KEY FK58743054834EDBB (InstitutionTCID),
  KEY FK58743053D2DAD9A (CollectionCCID),
  KEY FK587430584B8A3FA (ParentOrganizationID),
  KEY FK58743054BDD9E10 (SpecifyUserID),
  KEY FK587430597C961D8 (DivisionID),
  KEY FK587430587E99F68 (InstitutionCCID),
  KEY FK58743055327F942 (ModifiedByAgentID),
  KEY FK58743053D3567E9 (CollectionTCID),
  CONSTRAINT FK58743053D3567E9 FOREIGN KEY (CollectionTCID) REFERENCES collection (UserGroupScopeId),
  CONSTRAINT FK58743053D2DAD9A FOREIGN KEY (CollectionCCID) REFERENCES collection (UserGroupScopeId),
  CONSTRAINT FK58743054834EDBB FOREIGN KEY (InstitutionTCID) REFERENCES institutionnetwork (InstitutionNetworkID),
  CONSTRAINT FK58743054BDD9E10 FOREIGN KEY (SpecifyUserID) REFERENCES specifyuser (SpecifyUserID),
  CONSTRAINT FK58743055327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK58743057699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK587430584B8A3FA FOREIGN KEY (ParentOrganizationID) REFERENCES agent (AgentID),
  CONSTRAINT FK587430587E99F68 FOREIGN KEY (InstitutionCCID) REFERENCES institution (UserGroupScopeId),
  CONSTRAINT FK587430587F159B7 FOREIGN KEY (InstitutionTCID) REFERENCES institution (UserGroupScopeId),
  CONSTRAINT FK587430597C961D8 FOREIGN KEY (DivisionID) REFERENCES division (UserGroupScopeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table agentattachment
--

DROP TABLE IF EXISTS agentattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE agentattachment (
  AgentAttachmentID int(11) NOT NULL AUTO_INCREMENT,
  Ordinal int(11) NOT NULL,
  Remarks text,
  AgentID int(11) NOT NULL,
  
  AttachmentID int(11) NOT NULL,
  
  PRIMARY KEY (AgentAttachmentID),
  KEY FK56FE59E87699B003 (CreatedByAgentID),
  KEY FK56FE59E8384B3622 (AgentID),
  KEY FK56FE59E8C7E55084 (AttachmentID),
  KEY FK56FE59E85327F942 (ModifiedByAgentID),
  CONSTRAINT FK56FE59E85327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK56FE59E8384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK56FE59E87699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK56FE59E8C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table agentgeography
--

DROP TABLE IF EXISTS agentgeography;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE agentgeography (
  AgentGeographyID int(11) NOT NULL AUTO_INCREMENT,
  Remarks text,
  Role varchar(64) DEFAULT NULL,
  AgentID int(11) NOT NULL,
  
  GeographyID int(11) NOT NULL,
  
  PRIMARY KEY (AgentGeographyID),
  KEY FK89CDCA177699B003 (CreatedByAgentID),
  KEY FK89CDCA17384B3622 (AgentID),
  KEY FK89CDCA17D649F6D0 (GeographyID),
  KEY FK89CDCA175327F942 (ModifiedByAgentID),
  CONSTRAINT FK89CDCA175327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK89CDCA17384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK89CDCA177699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK89CDCA17D649F6D0 FOREIGN KEY (GeographyID) REFERENCES geography (GeographyID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table agentspecialty
--

DROP TABLE IF EXISTS agentspecialty;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE agentspecialty (
  AgentSpecialtyID int(11) NOT NULL AUTO_INCREMENT,
  OrderNumber int(11) NOT NULL,
  SpecialtyName varchar(64) NOT NULL,
  
  
  AgentID int(11) NOT NULL,
  PRIMARY KEY (AgentSpecialtyID),
  UNIQUE KEY AgentID (AgentID,OrderNumber),
  KEY FKDB5F57997699B003 (CreatedByAgentID),
  KEY FKDB5F5799384B3622 (AgentID),
  KEY FKDB5F57995327F942 (ModifiedByAgentID),
  CONSTRAINT FKDB5F57995327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKDB5F5799384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKDB5F57997699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table agentvariant
--

DROP TABLE IF EXISTS agentvariant;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE agentvariant (
  AgentVariantID int(11) NOT NULL AUTO_INCREMENT,
  Country varchar(2) DEFAULT NULL,
  Language varchar(2) DEFAULT NULL,
  Name varchar(255) DEFAULT NULL,
  VarType tinyint(4) NOT NULL,
  Variant varchar(2) DEFAULT NULL,
  AgentID int(11) NOT NULL,
  
  
  PRIMARY KEY (AgentVariantID),
  KEY FK8DA4DE07699B003 (CreatedByAgentID),
  KEY FK8DA4DE0384B3622 (AgentID),
  KEY FK8DA4DE05327F942 (ModifiedByAgentID),
  CONSTRAINT FK8DA4DE05327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK8DA4DE0384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK8DA4DE07699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table appraisal
--

--
-- Table structure for table attachmentimageattribute
--

DROP TABLE IF EXISTS attachmentimageattribute;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE attachmentimageattribute (
  AttachmentImageAttributeID int(11) NOT NULL AUTO_INCREMENT,

  CreativeCommons varchar(500) DEFAULT NULL,
  Height int(11) DEFAULT NULL,
  ImageType varchar(80) DEFAULT NULL,
  Magnification double DEFAULT NULL,
  MBImageID int(11) DEFAULT NULL,
  Remarks text,
  Resolution double DEFAULT NULL,
  TimestampLastSend datetime DEFAULT NULL,
  TimestampLastUpdateCheck datetime DEFAULT NULL,
  ViewDescription varchar(80) DEFAULT NULL,
  Width int(11) DEFAULT NULL,
  
  MorphBankViewID int(11) DEFAULT NULL,
  
  
  PRIMARY KEY (AttachmentImageAttributeID),
  KEY FK857D77847699B003 (CreatedByAgentID),
  KEY FK857D7784FD8D2A2A (MorphBankViewID),
  KEY FK857D77845327F942 (ModifiedByAgentID),
  CONSTRAINT FK857D77845327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK857D77847699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK857D7784FD8D2A2A FOREIGN KEY (MorphBankViewID) REFERENCES morphbankview (MorphBankViewID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table attachmentmetadata
--

DROP TABLE IF EXISTS attachmentmetadata;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE attachmentmetadata (
  AttachmentMetadataID int(11) NOT NULL AUTO_INCREMENT,

  Name varchar(64) NOT NULL,
  Value varchar(128) NOT NULL,
  
  AttachmentID int(11) DEFAULT NULL,
  
  PRIMARY KEY (AttachmentMetadataID),
  KEY FK991701527699B003 (CreatedByAgentID),
  KEY FK99170152C7E55084 (AttachmentID),
  KEY FK991701525327F942 (ModifiedByAgentID),
  CONSTRAINT FK991701525327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK991701527699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK99170152C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table attachmenttag
--

DROP TABLE IF EXISTS attachmenttag;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE attachmenttag (
  AttachmentTagID int(11) NOT NULL AUTO_INCREMENT,

  Tag varchar(64) NOT NULL,
  
  
  AttachmentID int(11) NOT NULL,
  PRIMARY KEY (AttachmentTagID),
  KEY FKA62FAF977699B003 (CreatedByAgentID),
  KEY FKA62FAF97C7E55084 (AttachmentID),
  KEY FKA62FAF975327F942 (ModifiedByAgentID),
  CONSTRAINT FKA62FAF975327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKA62FAF977699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKA62FAF97C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table attributedef
--

DROP TABLE IF EXISTS attributedef;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE attributedef (
  AttributeDefID int(11) NOT NULL AUTO_INCREMENT,

  DataType smallint(6) DEFAULT NULL,
  FieldName varchar(32) DEFAULT NULL,
  TableType smallint(6) DEFAULT NULL,
  
  
  DisciplineID int(11) NOT NULL,
  PrepTypeID int(11) DEFAULT NULL,
  PRIMARY KEY (AttributeDefID),
  KEY FKC36883E97699B003 (CreatedByAgentID),
  KEY FKC36883E94CE675DE (DisciplineID),
  KEY FKC36883E96E8973EC (PrepTypeID),
  KEY FKC36883E95327F942 (ModifiedByAgentID),
  CONSTRAINT FKC36883E95327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKC36883E94CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FKC36883E96E8973EC FOREIGN KEY (PrepTypeID) REFERENCES preptype (PrepTypeID),
  CONSTRAINT FKC36883E97699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table author
--

DROP TABLE IF EXISTS author;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE author (
  AuthorID int(11) NOT NULL AUTO_INCREMENT,

  OrderNumber smallint(6) NOT NULL,
  Remarks text,
  AgentID int(11) NOT NULL,
  
  ReferenceWorkID int(11) NOT NULL,
  
  PRIMARY KEY (AuthorID),
  UNIQUE KEY ReferenceWorkID (ReferenceWorkID,AgentID),
  KEY FKAC2D218B7699B003 (CreatedByAgentID),
  KEY FKAC2D218B384B3622 (AgentID),
  KEY FKAC2D218B69734F30 (ReferenceWorkID),
  KEY FKAC2D218B5327F942 (ModifiedByAgentID),
  CONSTRAINT FKAC2D218B5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKAC2D218B384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKAC2D218B69734F30 FOREIGN KEY (ReferenceWorkID) REFERENCES referencework (ReferenceWorkID),
  CONSTRAINT FKAC2D218B7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table autonumberingscheme
--

DROP TABLE IF EXISTS autonumberingscheme;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE autonumberingscheme (
  AutoNumberingSchemeID int(11) NOT NULL AUTO_INCREMENT,

  FormatName varchar(64) DEFAULT NULL,
  IsNumericOnly bit(1) NOT NULL,
  SchemeClassName varchar(64) DEFAULT NULL,
  SchemeName varchar(64) DEFAULT NULL,
  TableNumber int(11) NOT NULL,
  
  
  PRIMARY KEY (AutoNumberingSchemeID),
  KEY SchemeNameIDX (SchemeName),
  KEY FK8227D14F7699B003 (CreatedByAgentID),
  KEY FK8227D14F5327F942 (ModifiedByAgentID),
  CONSTRAINT FK8227D14F5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK8227D14F7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table autonumsch_coll
--

DROP TABLE IF EXISTS autonumsch_coll;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE autonumsch_coll (
  CollectionID int(11) NOT NULL,
  AutoNumberingSchemeID int(11) NOT NULL,
  PRIMARY KEY (CollectionID,AutoNumberingSchemeID),
  KEY FK46F04F2AFE55DD76 (AutoNumberingSchemeID),
  KEY FK46F04F2A8C2288BA (CollectionID),
  CONSTRAINT FK46F04F2A8C2288BA FOREIGN KEY (CollectionID) REFERENCES collection (UserGroupScopeId),
  CONSTRAINT FK46F04F2AFE55DD76 FOREIGN KEY (AutoNumberingSchemeID) REFERENCES autonumberingscheme (AutoNumberingSchemeID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table autonumsch_div
--

DROP TABLE IF EXISTS autonumsch_div;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE autonumsch_div (
  DivisionID int(11) NOT NULL,
  AutoNumberingSchemeID int(11) NOT NULL,
  PRIMARY KEY (DivisionID,AutoNumberingSchemeID),
  KEY FKA8BE493FE55DD76 (AutoNumberingSchemeID),
  KEY FKA8BE49397C961D8 (DivisionID),
  CONSTRAINT FKA8BE49397C961D8 FOREIGN KEY (DivisionID) REFERENCES division (UserGroupScopeId),
  CONSTRAINT FKA8BE493FE55DD76 FOREIGN KEY (AutoNumberingSchemeID) REFERENCES autonumberingscheme (AutoNumberingSchemeID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table autonumsch_dsp
--

DROP TABLE IF EXISTS autonumsch_dsp;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE autonumsch_dsp (
  DisciplineID int(11) NOT NULL,
  AutoNumberingSchemeID int(11) NOT NULL,
  PRIMARY KEY (DisciplineID,AutoNumberingSchemeID),
  KEY FKA8BE5C3FE55DD76 (AutoNumberingSchemeID),
  KEY FKA8BE5C34CE675DE (DisciplineID),
  CONSTRAINT FKA8BE5C34CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FKA8BE5C3FE55DD76 FOREIGN KEY (AutoNumberingSchemeID) REFERENCES autonumberingscheme (AutoNumberingSchemeID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table borrow
--

DROP TABLE IF EXISTS borrow;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE borrow (
  BorrowID int(11) NOT NULL AUTO_INCREMENT,

  CollectionMemberID int(11) NOT NULL,
  BorrowDate date DEFAULT NULL,
  BorrowDatePrecision tinyint(4) DEFAULT NULL,
  CurrentDueDate date DEFAULT NULL,
  DateClosed date DEFAULT NULL,
  InvoiceNumber varchar(50) NOT NULL,
  IsClosed bit(1) DEFAULT NULL,
  IsFinancialResponsibility bit(1) DEFAULT NULL,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  NumberOfItemsBorrowed int(11) DEFAULT NULL,
  OriginalDueDate date DEFAULT NULL,
  ReceivedDate date DEFAULT NULL,
  Remarks text,
  Text1 text,
  Text2 text,
  
  
  AddressOfRecordID int(11) DEFAULT NULL,
  
  PRIMARY KEY (BorrowID),
  KEY BorInvoiceNumberIDX (InvoiceNumber),
  KEY BorReceivedDateIDX (ReceivedDate),
  KEY BorColMemIDX (CollectionMemberID),
  KEY FKAD8CA9F57699B003 (CreatedByAgentID),
  KEY FKAD8CA9F5DC8B4810 (AddressOfRecordID),
  KEY FKAD8CA9F55327F942 (ModifiedByAgentID),
  CONSTRAINT FKAD8CA9F55327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKAD8CA9F57699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKAD8CA9F5DC8B4810 FOREIGN KEY (AddressOfRecordID) REFERENCES addressofrecord (AddressOfRecordID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table borrowagent
--

DROP TABLE IF EXISTS borrowagent;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE borrowagent (
  BorrowAgentID int(11) NOT NULL AUTO_INCREMENT,

  CollectionMemberID int(11) NOT NULL,
  Remarks text,
  Role varchar(32) NOT NULL,
  AgentID int(11) NOT NULL,
  BorrowID int(11) NOT NULL,
  
  
  PRIMARY KEY (BorrowAgentID),
  UNIQUE KEY Role (Role,AgentID,BorrowID),
  KEY BorColMemIDX2 (CollectionMemberID),
  KEY FKF48F8A307699B003 (CreatedByAgentID),
  KEY FKF48F8A30384B3622 (AgentID),
  KEY FKF48F8A30F8BF6F28 (BorrowID),
  KEY FKF48F8A305327F942 (ModifiedByAgentID),
  CONSTRAINT FKF48F8A305327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKF48F8A30384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKF48F8A307699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKF48F8A30F8BF6F28 FOREIGN KEY (BorrowID) REFERENCES borrow (BorrowID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table borrowattachment
--

DROP TABLE IF EXISTS borrowattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE borrowattachment (
  BorrowAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  Ordinal int(11) NOT NULL,
  Remarks text,
  AttachmentID int(11) NOT NULL,
  BorrowID int(11) NOT NULL,
  PRIMARY KEY (BorrowAttachmentID),
  KEY FK3263D4D87699B003 (CreatedByAgentID),
  KEY FK3263D4D8F8BF6F28 (BorrowID),
  KEY FK3263D4D8C7E55084 (AttachmentID),
  KEY FK3263D4D85327F942 (ModifiedByAgentID),
  CONSTRAINT FK3263D4D85327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK3263D4D87699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK3263D4D8C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID),
  CONSTRAINT FK3263D4D8F8BF6F28 FOREIGN KEY (BorrowID) REFERENCES borrow (BorrowID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table borrowmaterial
--

DROP TABLE IF EXISTS borrowmaterial;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE borrowmaterial (
  BorrowMaterialID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  Description varchar(50) DEFAULT NULL,
  InComments text,
  MaterialNumber varchar(50) NOT NULL,
  OutComments text,
  Quantity smallint(6) DEFAULT NULL,
  QuantityResolved smallint(6) DEFAULT NULL,
  QuantityReturned smallint(6) DEFAULT NULL,
  BorrowID int(11) NOT NULL,
  
  
  PRIMARY KEY (BorrowMaterialID),
  KEY DescriptionIDX (Description),
  KEY BorMaterialNumberIDX (MaterialNumber),
  KEY BorMaterialColMemIDX (CollectionMemberID),
  KEY FK86254A1C7699B003 (CreatedByAgentID),
  KEY FK86254A1CF8BF6F28 (BorrowID),
  KEY FK86254A1C5327F942 (ModifiedByAgentID),
  CONSTRAINT FK86254A1C5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK86254A1C7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK86254A1CF8BF6F28 FOREIGN KEY (BorrowID) REFERENCES borrow (BorrowID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table borrowreturnmaterial
--

DROP TABLE IF EXISTS borrowreturnmaterial;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE borrowreturnmaterial (
  BorrowReturnMaterialID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  Quantity smallint(6) DEFAULT NULL,
  Remarks text,
  ReturnedDate date DEFAULT NULL,
  BorrowMaterialID int(11) NOT NULL,
  
  ReturnedByID int(11) DEFAULT NULL,
  
  PRIMARY KEY (BorrowReturnMaterialID),
  KEY BorrowReturnedDateIDX (ReturnedDate),
  KEY BorrowReturnedColMemIDX (CollectionMemberID),
  KEY FKA8170B8C7699B003 (CreatedByAgentID),
  KEY FKA8170B8CC6A93143 (ReturnedByID),
  KEY FKA8170B8C83F392D6 (BorrowMaterialID),
  KEY FKA8170B8C5327F942 (ModifiedByAgentID),
  CONSTRAINT FKA8170B8C5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKA8170B8C7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKA8170B8C83F392D6 FOREIGN KEY (BorrowMaterialID) REFERENCES borrowmaterial (BorrowMaterialID),
  CONSTRAINT FKA8170B8CC6A93143 FOREIGN KEY (ReturnedByID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table collectingeventattachment
--

DROP TABLE IF EXISTS collectingeventattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE collectingeventattachment (
  CollectingEventAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  Ordinal int(11) NOT NULL,
  Remarks text,
  CollectingEventID int(11) NOT NULL,
  
  AttachmentID int(11) NOT NULL,
  
  PRIMARY KEY (CollectingEventAttachmentID),
  KEY CEAColMemIDX (CollectionMemberID),
  KEY FK32C365C57699B003 (CreatedByAgentID),
  KEY FK32C365C5B237E2BC (CollectingEventID),
  KEY FK32C365C5C7E55084 (AttachmentID),
  KEY FK32C365C55327F942 (ModifiedByAgentID),
  CONSTRAINT FK32C365C55327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK32C365C57699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK32C365C5B237E2BC FOREIGN KEY (CollectingEventID) REFERENCES collectingevent (CollectingEventID),
  CONSTRAINT FK32C365C5C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table collectingeventattr
--

DROP TABLE IF EXISTS collectingeventattr;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE collectingeventattr (
  AttrID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  DoubleValue double DEFAULT NULL,
  StrValue varchar(255) DEFAULT NULL,
  AttributeDefID int(11) NOT NULL,
  CollectingEventID int(11) NOT NULL,
  
  
  PRIMARY KEY (AttrID),
  KEY COLEVATColMemIDX (CollectionMemberID),
  KEY FK42A088137699B003 (CreatedByAgentID),
  KEY FK42A08813E84BA7B0 (AttributeDefID),
  KEY FK42A08813B237E2BC (CollectingEventID),
  KEY FK42A088135327F942 (ModifiedByAgentID),
  CONSTRAINT FK42A088135327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK42A088137699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK42A08813B237E2BC FOREIGN KEY (CollectingEventID) REFERENCES collectingevent (CollectingEventID),
  CONSTRAINT FK42A08813E84BA7B0 FOREIGN KEY (AttributeDefID) REFERENCES attributedef (AttributeDefID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table collectingeventattribute
--

DROP TABLE IF EXISTS collectingeventattribute;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE collectingeventattribute (
  CollectingEventAttributeID int(11) NOT NULL AUTO_INCREMENT,

  

  Number1 float(20,10) DEFAULT NULL,
  Number10 float(20,10) DEFAULT NULL,
  Number11 float(20,10) DEFAULT NULL,
  Number12 float(20,10) DEFAULT NULL,
  Number13 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  Number3 float(20,10) DEFAULT NULL,
  Number4 float(20,10) DEFAULT NULL,
  Number5 float(20,10) DEFAULT NULL,
  Number6 float(20,10) DEFAULT NULL,
  Number7 float(20,10) DEFAULT NULL,
  Number8 float(20,10) DEFAULT NULL,
  Number9 float(20,10) DEFAULT NULL,
  Remarks text,
  Text1 text,
  Text10 varchar(50) DEFAULT NULL,
  Text11 varchar(50) DEFAULT NULL,
  Text12 varchar(50) DEFAULT NULL,
  Text13 varchar(50) DEFAULT NULL,
  Text14 varchar(50) DEFAULT NULL,
  Text15 varchar(50) DEFAULT NULL,
  Text16 varchar(50) DEFAULT NULL,
  Text17 varchar(50) DEFAULT NULL,
  Text2 text,
  Text3 text,
  Text4 varchar(100) DEFAULT NULL,
  Text5 varchar(100) DEFAULT NULL,
  Text6 varchar(50) DEFAULT NULL,
  Text7 varchar(50) DEFAULT NULL,
  Text8 varchar(50) DEFAULT NULL,
  Text9 varchar(50) DEFAULT NULL,
  
  
  
  
  
  
  HostTaxonID int(11) DEFAULT NULL,
  
  DisciplineID int(11) NOT NULL,
  PRIMARY KEY (CollectingEventAttributeID),
  KEY COLEVATSDispIDX (DisciplineID),
  KEY FK9AD681BA7699B003 (CreatedByAgentID),
  KEY FK9AD681BA32C0CDC4 (HostTaxonID),
  KEY FK9AD681BA4CE675DE (DisciplineID),
  KEY FK9AD681BA5327F942 (ModifiedByAgentID),
  CONSTRAINT FK9AD681BA5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK9AD681BA32C0CDC4 FOREIGN KEY (HostTaxonID) REFERENCES taxon (TaxonID),
  CONSTRAINT FK9AD681BA4CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK9AD681BA7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table collectingtrip
--

DROP TABLE IF EXISTS collectingtrip;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE collectingtrip (
  CollectingTripID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectingTripName varchar(64) DEFAULT NULL,
  Cruise varchar(250) DEFAULT NULL,
  EndDate date DEFAULT NULL,
  EndDatePrecision tinyint(4) DEFAULT NULL,
  EndDateVerbatim varchar(50) DEFAULT NULL,
  EndTime smallint(6) DEFAULT NULL,
  Expedition varchar(250) DEFAULT NULL,
  Number1 int(11) DEFAULT NULL,
  Number2 int(11) DEFAULT NULL,
  Remarks text,
  Sponsor varchar(64) DEFAULT NULL,
  StartDate date DEFAULT NULL,
  StartDatePrecision tinyint(4) DEFAULT NULL,
  StartDateVerbatim varchar(50) DEFAULT NULL,
  StartTime smallint(6) DEFAULT NULL,

  Text2 varchar(128) DEFAULT NULL,
  Text3 varchar(64) DEFAULT NULL,
  Text4 varchar(64) DEFAULT NULL,
  Vessel varchar(250) DEFAULT NULL,
  
  
  
  
  DisciplineID int(11) NOT NULL,
  PRIMARY KEY (CollectingTripID),
  KEY COLTRPStartDateIDX (StartDate),
  KEY COLTRPNameIDX (CollectingTripName),
  KEY FK1080269D7699B003 (CreatedByAgentID),
  KEY FK1080269D4CE675DE (DisciplineID),
  KEY FK1080269D5327F942 (ModifiedByAgentID),
  CONSTRAINT FK1080269D5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK1080269D4CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK1080269D7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table collectionobject
--

DROP TABLE IF EXISTS collectionobject;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE collectionobject (
  CollectionObjectID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  AltCatalogNumber varchar(32) DEFAULT NULL,
  Availability varchar(32) DEFAULT NULL,
  CatalogNumber varchar(32) DEFAULT NULL,
  CatalogedDate date DEFAULT NULL,
  CatalogedDatePrecision tinyint(4) DEFAULT NULL,
  CatalogedDateVerbatim varchar(32) DEFAULT NULL,
  CountAmt int(11) DEFAULT NULL,
  Deaccessioned bit(1) DEFAULT NULL,
  Description varchar(255) DEFAULT NULL,
  FieldNumber varchar(50) DEFAULT NULL,
  GUID varchar(128) DEFAULT NULL,
  Integer1 int(11) DEFAULT NULL,
  Integer2 int(11) DEFAULT NULL,
  InventoryDate date DEFAULT NULL,
  Modifier varchar(50) DEFAULT NULL,
  Name varchar(64) DEFAULT NULL,
  Notifications varchar(32) DEFAULT NULL,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  ObjectCondition varchar(64) DEFAULT NULL,
  OCR text,
  ProjectNumber varchar(64) DEFAULT NULL,
  Remarks text,
  ReservedInteger3 int(11) DEFAULT NULL,
  ReservedInteger4 int(11) DEFAULT NULL,
  ReservedText varchar(128) DEFAULT NULL,
  ReservedText2 varchar(128) DEFAULT NULL,
  ReservedText3 varchar(128) DEFAULT NULL,
  Restrictions varchar(32) DEFAULT NULL,
  SGRStatus tinyint(4) DEFAULT NULL,
  Text1 text,
  Text2 text,
  Text3 text,
  TotalValue decimal(12,2) DEFAULT NULL,
  Visibility tinyint(4) DEFAULT NULL,
  
  
  
  
  
  
  
  ContainerID int(11) DEFAULT NULL,
  VisibilitySetByID int(11) DEFAULT NULL,
  CatalogerID int(11) DEFAULT NULL,
  PaleoContextID int(11) DEFAULT NULL,
  AppraisalID int(11) DEFAULT NULL,
  CollectionID int(11) NOT NULL,
  ContainerOwnerID int(11) DEFAULT NULL,
  AccessionID int(11) DEFAULT NULL,
  CollectingEventID int(11) DEFAULT NULL,
  
  FieldNotebookPageID int(11) DEFAULT NULL,
  CollectionObjectAttributeID int(11) DEFAULT NULL,
  PRIMARY KEY (CollectionObjectID),
  UNIQUE KEY CollectionID (CollectionID,CatalogNumber),
  KEY ColObjGuidIDX (GUID),
  KEY FieldNumberIDX (FieldNumber),
  KEY COColMemIDX (CollectionMemberID),
  KEY CatalogedDateIDX (CatalogedDate),
  KEY CatalogNumberIDX (CatalogNumber),
  KEY FKC1D4635D73BF3AE0 (FieldNotebookPageID),
  KEY FKC1D4635DA40125AB (ContainerOwnerID),
  KEY FKC1D4635DA141B896 (CollectionObjectAttributeID),
  KEY FKC1D4635DB15CB762 (AppraisalID),
  KEY FKC1D4635D7699B003 (CreatedByAgentID),
  KEY FKC1D4635D7BF1F70B (VisibilitySetByID),
  KEY FKC1D4635DB237E2BC (CollectingEventID),
  KEY FKC1D4635D97ECD2B2 (PaleoContextID),
  KEY FKC1D4635DE816739A (ContainerID),
  KEY FKC1D4635D8C2288BA (CollectionID),
  KEY FKC1D4635D3B87E163 (CatalogerID),
  KEY FKC1D4635D3925EE20 (AccessionID),
  KEY FKC1D4635D5327F942 (ModifiedByAgentID),
  CONSTRAINT FKC1D4635D5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKC1D4635D3925EE20 FOREIGN KEY (AccessionID) REFERENCES accession (AccessionID),
  CONSTRAINT FKC1D4635D3B87E163 FOREIGN KEY (CatalogerID) REFERENCES agent (AgentID),
  CONSTRAINT FKC1D4635D73BF3AE0 FOREIGN KEY (FieldNotebookPageID) REFERENCES fieldnotebookpage (FieldNotebookPageID),
  CONSTRAINT FKC1D4635D7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKC1D4635D7BF1F70B FOREIGN KEY (VisibilitySetByID) REFERENCES specifyuser (SpecifyUserID),
  CONSTRAINT FKC1D4635D8C2288BA FOREIGN KEY (CollectionID) REFERENCES collection (UserGroupScopeId),
  CONSTRAINT FKC1D4635D97ECD2B2 FOREIGN KEY (PaleoContextID) REFERENCES paleocontext (PaleoContextID),
  CONSTRAINT FKC1D4635DA141B896 FOREIGN KEY (CollectionObjectAttributeID) REFERENCES collectionobjectattribute (CollectionObjectAttributeID),
  CONSTRAINT FKC1D4635DA40125AB FOREIGN KEY (ContainerOwnerID) REFERENCES container (ContainerID),
  CONSTRAINT FKC1D4635DB15CB762 FOREIGN KEY (AppraisalID) REFERENCES appraisal (AppraisalID),
  CONSTRAINT FKC1D4635DB237E2BC FOREIGN KEY (CollectingEventID) REFERENCES collectingevent (CollectingEventID),
  CONSTRAINT FKC1D4635DE816739A FOREIGN KEY (ContainerID) REFERENCES container (ContainerID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table collectionobjectattachment
--

DROP TABLE IF EXISTS collectionobjectattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE collectionobjectattachment (
  CollectionObjectAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  Ordinal int(11) NOT NULL,
  Remarks text,
  AttachmentID int(11) NOT NULL,
  CollectionObjectID int(11) NOT NULL,
  
  
  PRIMARY KEY (CollectionObjectAttachmentID),
  KEY COLOBJATTColMemIDX (CollectionMemberID),
  KEY FK9C00EC407699B003 (CreatedByAgentID),
  KEY FK9C00EC4075E37458 (CollectionObjectID),
  KEY FK9C00EC40C7E55084 (AttachmentID),
  KEY FK9C00EC405327F942 (ModifiedByAgentID),
  CONSTRAINT FK9C00EC405327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK9C00EC4075E37458 FOREIGN KEY (CollectionObjectID) REFERENCES collectionobject (CollectionObjectID),
  CONSTRAINT FK9C00EC407699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK9C00EC40C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table collectionobjectattr
--

DROP TABLE IF EXISTS collectionobjectattr;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE collectionobjectattr (
  AttrID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  DoubleValue double DEFAULT NULL,
  StrValue varchar(255) DEFAULT NULL,
  
  CollectionObjectID int(11) NOT NULL,
  AttributeDefID int(11) NOT NULL,
  
  PRIMARY KEY (AttrID),
  KEY COLOBJATRSColMemIDX (CollectionMemberID),
  KEY FK303746CE7699B003 (CreatedByAgentID),
  KEY FK303746CE75E37458 (CollectionObjectID),
  KEY FK303746CEE84BA7B0 (AttributeDefID),
  KEY FK303746CE5327F942 (ModifiedByAgentID),
  CONSTRAINT FK303746CE5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK303746CE75E37458 FOREIGN KEY (CollectionObjectID) REFERENCES collectionobject (CollectionObjectID),
  CONSTRAINT FK303746CE7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK303746CEE84BA7B0 FOREIGN KEY (AttributeDefID) REFERENCES attributedef (AttributeDefID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table collectionobjectattribute
--

DROP TABLE IF EXISTS collectionobjectattribute;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE collectionobjectattribute (
  CollectionObjectAttributeID int(11) NOT NULL AUTO_INCREMENT,
  CollectionMemberID int(11) NOT NULL,
  BottomDistance float(20,10) DEFAULT NULL,
  Direction varchar(32) DEFAULT NULL,
  DistanceUnits varchar(16) DEFAULT NULL,
  PositionState varchar(32) DEFAULT NULL,
  Remarks text,
  Text1 text,
  Text10 varchar(50) DEFAULT NULL,
  Text11 varchar(50) DEFAULT NULL,
  Text12 varchar(50) DEFAULT NULL,
  Text13 varchar(50) DEFAULT NULL,
  Text14 varchar(50) DEFAULT NULL,
  Text15 varchar(64) DEFAULT NULL,
  Text16 text,
  Text17 text,
  Text18 text,
  Text2 text,
  Text3 text,
  Text4 varchar(50) DEFAULT NULL,
  Text5 varchar(50) DEFAULT NULL,
  Text6 varchar(100) DEFAULT NULL,
  Text7 varchar(100) DEFAULT NULL,
  Text8 varchar(50) DEFAULT NULL,
  Text9 varchar(50) DEFAULT NULL,
  TopDistance float(20,10) DEFAULT NULL,
  
  
  PRIMARY KEY (CollectionObjectAttributeID),
  KEY COLOBJATTRSColMemIDX (CollectionMemberID),
  KEY FK32E0BFDF7699B003 (CreatedByAgentID),
  KEY FK32E0BFDF5327F942 (ModifiedByAgentID),
  CONSTRAINT FK32E0BFDF5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK32E0BFDF7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table collectionobjectcitation
--

DROP TABLE IF EXISTS collectionobjectcitation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE collectionobjectcitation (
  CollectionObjectCitationID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  FigureNumber varchar(50) DEFAULT NULL,
  IsFigured bit(1) DEFAULT NULL,
  PageNumber varchar(50) DEFAULT NULL,
  PlateNumber varchar(50) DEFAULT NULL,
  Remarks text,
  CollectionObjectID int(11) NOT NULL,
  
  
  ReferenceWorkID int(11) NOT NULL,
  PRIMARY KEY (CollectionObjectCitationID),
  KEY COCITColMemIDX (CollectionMemberID),
  KEY FKAB9FC1447699B003 (CreatedByAgentID),
  KEY FKAB9FC14475E37458 (CollectionObjectID),
  KEY FKAB9FC14469734F30 (ReferenceWorkID),
  KEY FKAB9FC1445327F942 (ModifiedByAgentID),
  CONSTRAINT FKAB9FC1445327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKAB9FC14469734F30 FOREIGN KEY (ReferenceWorkID) REFERENCES referencework (ReferenceWorkID),
  CONSTRAINT FKAB9FC14475E37458 FOREIGN KEY (CollectionObjectID) REFERENCES collectionobject (CollectionObjectID),
  CONSTRAINT FKAB9FC1447699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table collectionrelationship
--

DROP TABLE IF EXISTS collectionrelationship;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE collectionrelationship (
  CollectionRelationshipID int(11) NOT NULL AUTO_INCREMENT,

  

  Text1 varchar(32) DEFAULT NULL,
  Text2 varchar(32) DEFAULT NULL,
  
  
  RightSideCollectionID int(11) NOT NULL,
  LeftSideCollectionID int(11) NOT NULL,
  CollectionRelTypeID int(11) DEFAULT NULL,
  PRIMARY KEY (CollectionRelationshipID),
  KEY FK246327D67699B003 (CreatedByAgentID),
  KEY FK246327D678903837 (LeftSideCollectionID),
  KEY FK246327D6637B3A82 (CollectionRelTypeID),
  KEY FK246327D68240904C (RightSideCollectionID),
  KEY FK246327D65327F942 (ModifiedByAgentID),
  CONSTRAINT FK246327D65327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK246327D6637B3A82 FOREIGN KEY (CollectionRelTypeID) REFERENCES collectionreltype (CollectionRelTypeID),
  CONSTRAINT FK246327D67699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK246327D678903837 FOREIGN KEY (LeftSideCollectionID) REFERENCES collectionobject (CollectionObjectID),
  CONSTRAINT FK246327D68240904C FOREIGN KEY (RightSideCollectionID) REFERENCES collectionobject (CollectionObjectID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table collectionreltype
--

DROP TABLE IF EXISTS collectionreltype;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE collectionreltype (
  CollectionRelTypeID int(11) NOT NULL AUTO_INCREMENT,

  

  Name varchar(32) DEFAULT NULL,
  Remarks varchar(4096) DEFAULT NULL,
  LeftSideCollectionID int(11) DEFAULT NULL,
  
  
  RightSideCollectionID int(11) DEFAULT NULL,
  PRIMARY KEY (CollectionRelTypeID),
  KEY FK1CAC96F57699B003 (CreatedByAgentID),
  KEY FK1CAC96F5CB93CD98 (LeftSideCollectionID),
  KEY FK1CAC96F5D54425AD (RightSideCollectionID),
  KEY FK1CAC96F55327F942 (ModifiedByAgentID),
  CONSTRAINT FK1CAC96F55327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK1CAC96F57699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK1CAC96F5CB93CD98 FOREIGN KEY (LeftSideCollectionID) REFERENCES collection (UserGroupScopeId),
  CONSTRAINT FK1CAC96F5D54425AD FOREIGN KEY (RightSideCollectionID) REFERENCES collection (UserGroupScopeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table commonnametx
--

DROP TABLE IF EXISTS commonnametx;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE commonnametx (
  CommonNameTxID int(11) NOT NULL AUTO_INCREMENT,

  

  Author varchar(128) DEFAULT NULL,
  Country varchar(2) DEFAULT NULL,
  Language varchar(2) DEFAULT NULL,
  Name varchar(255) DEFAULT NULL,
  Variant varchar(2) DEFAULT NULL,
  TaxonID int(11) NOT NULL,
  
  
  PRIMARY KEY (CommonNameTxID),
  KEY CommonNameTxNameIDX (Name),
  KEY CommonNameTxCountryIDX (Country),
  KEY FK3413DFFA7699B003 (CreatedByAgentID),
  KEY FK3413DFFA1D39F06C (TaxonID),
  KEY FK3413DFFA5327F942 (ModifiedByAgentID),
  CONSTRAINT FK3413DFFA5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK3413DFFA1D39F06C FOREIGN KEY (TaxonID) REFERENCES taxon (TaxonID),
  CONSTRAINT FK3413DFFA7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table commonnametxcitation
--

DROP TABLE IF EXISTS commonnametxcitation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE commonnametxcitation (
  CommonNameTxCitationID int(11) NOT NULL AUTO_INCREMENT,

  

  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  Remarks text,
  Text1 text,
  Text2 text,
  
  
  ReferenceWorkID int(11) NOT NULL,
  CommonNameTxID int(11) NOT NULL,
  
  
  PRIMARY KEY (CommonNameTxCitationID),
  KEY FK829B50E17699B003 (CreatedByAgentID),
  KEY FK829B50E169734F30 (ReferenceWorkID),
  KEY FK829B50E115A0FFF2 (CommonNameTxID),
  KEY FK829B50E15327F942 (ModifiedByAgentID),
  CONSTRAINT FK829B50E15327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK829B50E115A0FFF2 FOREIGN KEY (CommonNameTxID) REFERENCES commonnametx (CommonNameTxID),
  CONSTRAINT FK829B50E169734F30 FOREIGN KEY (ReferenceWorkID) REFERENCES referencework (ReferenceWorkID),
  CONSTRAINT FK829B50E17699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table conservdescription
--

DROP TABLE IF EXISTS conservdescription;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE conservdescription (
  ConservDescriptionID int(11) NOT NULL AUTO_INCREMENT,

  

  BackgroundInfo text,
  Composition text,
  Description text,
  DisplayRecommendations text,
  Height float(20,10) DEFAULT NULL,
  LightRecommendations text,
  ObjLength float(20,10) DEFAULT NULL,
  OtherRecommendations text,
  Remarks text,
  ShortDesc varchar(128) DEFAULT NULL,
  Source text,
  Units varchar(16) DEFAULT NULL,
  Width float(20,10) DEFAULT NULL,
  DivisionID int(11) DEFAULT NULL,
  
  
  CollectionObjectID int(11) DEFAULT NULL,
  PRIMARY KEY (ConservDescriptionID),
  KEY ConservDescShortDescIDX (ShortDesc),
  KEY FKC040F4647699B003 (CreatedByAgentID),
  KEY FKC040F46475E37458 (CollectionObjectID),
  KEY FKC040F46497C961D8 (DivisionID),
  KEY FKC040F4645327F942 (ModifiedByAgentID),
  CONSTRAINT FKC040F4645327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKC040F46475E37458 FOREIGN KEY (CollectionObjectID) REFERENCES collectionobject (CollectionObjectID),
  CONSTRAINT FKC040F4647699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKC040F46497C961D8 FOREIGN KEY (DivisionID) REFERENCES division (UserGroupScopeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table conservdescriptionattachment
--

DROP TABLE IF EXISTS conservdescriptionattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE conservdescriptionattachment (
  ConservDescriptionAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  AttachmentID int(11) NOT NULL,
  ConservDescriptionID int(11) NOT NULL,
  
  
  PRIMARY KEY (ConservDescriptionAttachmentID),
  KEY FK1EED20877699B003 (CreatedByAgentID),
  KEY FK1EED20878FF9CFA6 (ConservDescriptionID),
  KEY FK1EED2087C7E55084 (AttachmentID),
  KEY FK1EED20875327F942 (ModifiedByAgentID),
  CONSTRAINT FK1EED20875327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK1EED20877699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK1EED20878FF9CFA6 FOREIGN KEY (ConservDescriptionID) REFERENCES conservdescription (ConservDescriptionID),
  CONSTRAINT FK1EED2087C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table conservevent
--

DROP TABLE IF EXISTS conservevent;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE conservevent (
  ConservEventID int(11) NOT NULL AUTO_INCREMENT,

  

  AdvTestingExam text,
  AdvTestingExamResults text,
  CompletedComments text,
  CompletedDate date DEFAULT NULL,
  CompletedDatePrecision tinyint(4) DEFAULT '1',
  ConditionReport text,
  CuratorApprovalDate date DEFAULT NULL,
  CuratorApprovalDatePrecision tinyint(4) DEFAULT '1',
  ExamDate date DEFAULT NULL,
  ExamDatePrecision tinyint(4) DEFAULT '1',
  Number1 int(11) DEFAULT NULL,
  Number2 int(11) DEFAULT NULL,
  PhotoDocs text,
  Remarks text,
  Text1 varchar(64) DEFAULT NULL,
  Text2 varchar(64) DEFAULT NULL,
  TreatmentCompDate date DEFAULT NULL,
  TreatmentCompDatePrecision tinyint(4) DEFAULT '1',
  TreatmentReport text,
  
  
  
  TreatedByAgentID int(11) DEFAULT NULL,
  
  ConservDescriptionID int(11) NOT NULL,
  CuratorID int(11) DEFAULT NULL,
  ExaminedByAgentID int(11) DEFAULT NULL,
  PRIMARY KEY (ConservEventID),
  KEY ConservCompletedDateIDX (CompletedDate),
  KEY ConservExamDateIDX (ExamDate),
  KEY FK74A8510271496BD2 (TreatedByAgentID),
  KEY FK74A851027699B003 (CreatedByAgentID),
  KEY FK74A8510227E00C28 (ExaminedByAgentID),
  KEY FK74A85102828C4E73 (CuratorID),
  KEY FK74A851028FF9CFA6 (ConservDescriptionID),
  KEY FK74A851025327F942 (ModifiedByAgentID),
  CONSTRAINT FK74A851025327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK74A8510227E00C28 FOREIGN KEY (ExaminedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK74A8510271496BD2 FOREIGN KEY (TreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK74A851027699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK74A85102828C4E73 FOREIGN KEY (CuratorID) REFERENCES agent (AgentID),
  CONSTRAINT FK74A851028FF9CFA6 FOREIGN KEY (ConservDescriptionID) REFERENCES conservdescription (ConservDescriptionID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table conserveventattachment
--

DROP TABLE IF EXISTS conserveventattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE conserveventattachment (
  ConservEventAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  AttachmentID int(11) NOT NULL,
  
  
  ConservEventID int(11) NOT NULL,
  PRIMARY KEY (ConservEventAttachmentID),
  KEY FKD3F7CFA57699B003 (CreatedByAgentID),
  KEY FKD3F7CFA5F849E7A2 (ConservEventID),
  KEY FKD3F7CFA5C7E55084 (AttachmentID),
  KEY FKD3F7CFA55327F942 (ModifiedByAgentID),
  CONSTRAINT FKD3F7CFA55327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKD3F7CFA57699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKD3F7CFA5C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID),
  CONSTRAINT FKD3F7CFA5F849E7A2 FOREIGN KEY (ConservEventID) REFERENCES conservevent (ConservEventID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table container
--

DROP TABLE IF EXISTS container;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE container (
  ContainerID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  Description varchar(255) DEFAULT NULL,
  Name varchar(64) DEFAULT NULL,
  Number int(11) DEFAULT NULL,
  Type smallint(6) DEFAULT NULL,
  
  StorageID int(11) DEFAULT NULL,
  ParentID int(11) DEFAULT NULL,
  
  PRIMARY KEY (ContainerID),
  KEY ContainerNameIDX (Name),
  KEY ContainerMemIDX (CollectionMemberID),
  KEY FKE7814C817699B003 (CreatedByAgentID),
  KEY FKE7814C8121C1C983 (ParentID),
  KEY FKE7814C815327F942 (ModifiedByAgentID),
  KEY FKE7814C81EB48144E (StorageID),
  CONSTRAINT FKE7814C81EB48144E FOREIGN KEY (StorageID) REFERENCES storage (StorageID),
  CONSTRAINT FKE7814C8121C1C983 FOREIGN KEY (ParentID) REFERENCES container (ContainerID),
  CONSTRAINT FKE7814C815327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKE7814C817699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table datatype
--

DROP TABLE IF EXISTS datatype;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE datatype (
  DataTypeID int(11) NOT NULL AUTO_INCREMENT,

  

  Name varchar(50) DEFAULT NULL,
  
  
  PRIMARY KEY (DataTypeID),
  KEY FK6AB199E47699B003 (CreatedByAgentID),
  KEY FK6AB199E45327F942 (ModifiedByAgentID),
  CONSTRAINT FK6AB199E45327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK6AB199E47699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table deaccession
--

DROP TABLE IF EXISTS deaccession;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE deaccession (
  DeaccessionID int(11) NOT NULL AUTO_INCREMENT,

  

  DeaccessionDate date DEFAULT NULL,
  DeaccessionNumber varchar(50) DEFAULT NULL,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  Remarks text,
  Text1 text,
  Text2 text,
  Type varchar(64) DEFAULT NULL,
  
  
  
  AccessionID int(11) DEFAULT NULL,
  
  PRIMARY KEY (DeaccessionID),
  KEY DeaccessionNumberIDX (DeaccessionNumber),
  KEY DeaccessionDateIDX (DeaccessionDate),
  KEY FKC3EACC37699B003 (CreatedByAgentID),
  KEY FKC3EACC33925EE20 (AccessionID),
  KEY FKC3EACC35327F942 (ModifiedByAgentID),
  CONSTRAINT FKC3EACC35327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKC3EACC33925EE20 FOREIGN KEY (AccessionID) REFERENCES accession (AccessionID),
  CONSTRAINT FKC3EACC37699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table deaccessionagent
--

DROP TABLE IF EXISTS deaccessionagent;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE deaccessionagent (
  DeaccessionAgentID int(11) NOT NULL AUTO_INCREMENT,

  

  Remarks text,
  Role varchar(50) NOT NULL,
  DeaccessionID int(11) NOT NULL,
  AgentID int(11) NOT NULL,
  
  
  PRIMARY KEY (DeaccessionAgentID),
  UNIQUE KEY Role (Role,AgentID,DeaccessionID),
  KEY FKBE5518227699B003 (CreatedByAgentID),
  KEY FKBE551822384B3622 (AgentID),
  KEY FKBE551822BE26B05E (DeaccessionID),
  KEY FKBE5518225327F942 (ModifiedByAgentID),
  CONSTRAINT FKBE5518225327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKBE551822384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKBE5518227699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKBE551822BE26B05E FOREIGN KEY (DeaccessionID) REFERENCES deaccession (DeaccessionID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table deaccessionpreparation
--

DROP TABLE IF EXISTS deaccessionpreparation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE deaccessionpreparation (
  DeaccessionPreparationID int(11) NOT NULL AUTO_INCREMENT,

  

  Quantity smallint(6) DEFAULT NULL,
  Remarks text,
  
  
  DeaccessionID int(11) NOT NULL,
  PreparationID int(11) DEFAULT NULL,
  PRIMARY KEY (DeaccessionPreparationID),
  KEY FK6A06F1F47699B003 (CreatedByAgentID),
  KEY FK6A06F1F4BE26B05E (DeaccessionID),
  KEY FK6A06F1F418627F06 (PreparationID),
  KEY FK6A06F1F45327F942 (ModifiedByAgentID),
  CONSTRAINT FK6A06F1F45327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK6A06F1F418627F06 FOREIGN KEY (PreparationID) REFERENCES preparation (PreparationID),
  CONSTRAINT FK6A06F1F47699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK6A06F1F4BE26B05E FOREIGN KEY (DeaccessionID) REFERENCES deaccession (DeaccessionID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table determinationcitation
--

DROP TABLE IF EXISTS determinationcitation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE determinationcitation (
  DeterminationCitationID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  Remarks text,
  
  DeterminationID int(11) NOT NULL,
  
  ReferenceWorkID int(11) NOT NULL,
  PRIMARY KEY (DeterminationCitationID),
  UNIQUE KEY ReferenceWorkID (ReferenceWorkID,DeterminationID),
  KEY DetCitColMemIDX (CollectionMemberID),
  KEY FK259B07CA7699B003 (CreatedByAgentID),
  KEY FK259B07CA69734F30 (ReferenceWorkID),
  KEY FK259B07CA47AE835E (DeterminationID),
  KEY FK259B07CA5327F942 (ModifiedByAgentID),
  CONSTRAINT FK259B07CA5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK259B07CA47AE835E FOREIGN KEY (DeterminationID) REFERENCES determination (DeterminationID),
  CONSTRAINT FK259B07CA69734F30 FOREIGN KEY (ReferenceWorkID) REFERENCES referencework (ReferenceWorkID),
  CONSTRAINT FK259B07CA7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table discipline
--

DROP TABLE IF EXISTS discipline;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE discipline (
  UserGroupScopeId int(11) NOT NULL,

  

  
  
  disciplineId int(11) DEFAULT NULL,
  IsPaleoContextEmbedded bit(1) NOT NULL,
  Name varchar(64) DEFAULT NULL,
  PaleoContextChildTable varchar(50) DEFAULT NULL,
  RegNumber varchar(24) DEFAULT NULL,
  Type varchar(64) DEFAULT NULL,
  GeographyTreeDefID int(11) NOT NULL,
  DivisionID int(11) NOT NULL,
  DataTypeID int(11) NOT NULL,
  LithoStratTreeDefID int(11) DEFAULT NULL,
  GeologicTimePeriodTreeDefID int(11) NOT NULL,
  TaxonTreeDefID int(11) DEFAULT NULL,
  PRIMARY KEY (UserGroupScopeId),
  KEY DisciplineNameIDX (Name),
  KEY FK157B9B709988ED70 (GeologicTimePeriodTreeDefID),
  KEY FK3D0021607699B003157b9b70 (CreatedByAgentID),
  KEY FK157B9B70EFA9D5F8 (TaxonTreeDefID),
  KEY FK157B9B70BF9C9714 (GeographyTreeDefID),
  KEY FK157B9B7097C961D8 (DivisionID),
  KEY FK157B9B7072939D3A (LithoStratTreeDefID),
  KEY FK157B9B70D62E36A6 (DataTypeID),
  KEY FK3D0021605327F942157b9b70 (ModifiedByAgentID),
  CONSTRAINT FK3D0021605327F942157b9b70 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK157B9B7072939D3A FOREIGN KEY (LithoStratTreeDefID) REFERENCES lithostrattreedef (LithoStratTreeDefID),
  CONSTRAINT FK157B9B7097C961D8 FOREIGN KEY (DivisionID) REFERENCES division (UserGroupScopeId),
  CONSTRAINT FK157B9B709988ED70 FOREIGN KEY (GeologicTimePeriodTreeDefID) REFERENCES geologictimeperiodtreedef (GeologicTimePeriodTreeDefID),
  CONSTRAINT FK157B9B70BF9C9714 FOREIGN KEY (GeographyTreeDefID) REFERENCES geographytreedef (GeographyTreeDefID),
  CONSTRAINT FK157B9B70D62E36A6 FOREIGN KEY (DataTypeID) REFERENCES datatype (DataTypeID),
  CONSTRAINT FK157B9B70EFA9D5F8 FOREIGN KEY (TaxonTreeDefID) REFERENCES taxontreedef (TaxonTreeDefID),
  CONSTRAINT FK3D0021607699B003157b9b70 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table division
--

DROP TABLE IF EXISTS division;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE division (
  UserGroupScopeId int(11) NOT NULL,

  

  
  
  Abbrev varchar(64) DEFAULT NULL,
  AltName varchar(128) DEFAULT NULL,
  Description text,
  DisciplineType varchar(64) DEFAULT NULL,
  divisionId int(11) DEFAULT NULL,
  IconURI varchar(255) DEFAULT NULL,
  Name varchar(255) DEFAULT NULL,
  RegNumber varchar(24) DEFAULT NULL,
  Remarks text,
  Uri varchar(255) DEFAULT NULL,
  AddressID int(11) DEFAULT NULL,
  InstitutionID int(11) NOT NULL,
  PRIMARY KEY (UserGroupScopeId),
  KEY DivisionNameIDX (Name),
  KEY FK3D0021607699B00315bd30ad (CreatedByAgentID),
  KEY FK15BD30AD81223908 (InstitutionID),
  KEY FK15BD30ADE6A64D00 (AddressID),
  KEY FK3D0021605327F94215bd30ad (ModifiedByAgentID),
  CONSTRAINT FK3D0021605327F94215bd30ad FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK15BD30AD81223908 FOREIGN KEY (InstitutionID) REFERENCES institution (UserGroupScopeId),
  CONSTRAINT FK15BD30ADE6A64D00 FOREIGN KEY (AddressID) REFERENCES address (AddressID),
  CONSTRAINT FK3D0021607699B00315bd30ad FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table dnasequence
--

DROP TABLE IF EXISTS dnasequence;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE dnasequence (
  DnaSequenceID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  AmbiguousResidues int(11) DEFAULT NULL,
  BOLDBarcodeID varchar(32) DEFAULT NULL,
  BOLDLastUpdateDate date DEFAULT NULL,
  BOLDSampleID varchar(32) DEFAULT NULL,
  BOLDTranslationMatrix varchar(64) DEFAULT NULL,
  CompA int(11) DEFAULT NULL,
  CompC int(11) DEFAULT NULL,
  CompG int(11) DEFAULT NULL,
  compT int(11) DEFAULT NULL,
  GenBankAccessionNumber varchar(32) DEFAULT NULL,
  GeneSequence text,
  MoleculeType varchar(32) DEFAULT NULL,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  Number3 float(20,10) DEFAULT NULL,
  Remarks text,
  TargetMarker varchar(32) DEFAULT NULL,
  Text1 varchar(32) DEFAULT NULL,
  Text2 varchar(32) DEFAULT NULL,
  Text3 varchar(64) DEFAULT NULL,
  TotalResidues int(11) DEFAULT NULL,
  
  
  
  CollectionObjectID int(11) DEFAULT NULL,
  AgentID int(11) DEFAULT NULL,
  
  
  PRIMARY KEY (DnaSequenceID),
  KEY BOLDSampleIDX (BOLDSampleID),
  KEY BOLDBarcodeIDX (BOLDBarcodeID),
  KEY GenBankAccIDX (GenBankAccessionNumber),
  KEY FK9F42F5D87699B003 (CreatedByAgentID),
  KEY FK9F42F5D875E37458 (CollectionObjectID),
  KEY FK9F42F5D8384B3622 (AgentID),
  KEY FK9F42F5D85327F942 (ModifiedByAgentID),
  CONSTRAINT FK9F42F5D85327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK9F42F5D8384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK9F42F5D875E37458 FOREIGN KEY (CollectionObjectID) REFERENCES collectionobject (CollectionObjectID),
  CONSTRAINT FK9F42F5D87699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table dnasequenceattachment
--

DROP TABLE IF EXISTS dnasequenceattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE dnasequenceattachment (
  DnaSequenceAttachmentId int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  AttachmentID int(11) NOT NULL,
  
  DnaSequenceID int(11) NOT NULL,
  
  PRIMARY KEY (DnaSequenceAttachmentId),
  KEY FKFFC2E0FB7699B003 (CreatedByAgentID),
  KEY FKFFC2E0FBC7E55084 (AttachmentID),
  KEY FKFFC2E0FB265FB168 (DnaSequenceID),
  KEY FKFFC2E0FB5327F942 (ModifiedByAgentID),
  CONSTRAINT FKFFC2E0FB5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKFFC2E0FB265FB168 FOREIGN KEY (DnaSequenceID) REFERENCES dnasequence (DnaSequenceID),
  CONSTRAINT FKFFC2E0FB7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKFFC2E0FBC7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table dnasequencerunattachment
--

DROP TABLE IF EXISTS dnasequencerunattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE dnasequencerunattachment (
  DnaSequencingRunAttachmentId int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  
  AttachmentID int(11) NOT NULL,
  
  DnaSequencingRunID int(11) NOT NULL,
  PRIMARY KEY (DnaSequencingRunAttachmentId),
  KEY FKD0DAEB167699B003 (CreatedByAgentID),
  KEY FKD0DAEB16C7E55084 (AttachmentID),
  KEY FKD0DAEB1678F036AA (DnaSequencingRunID),
  KEY FKD0DAEB165327F942 (ModifiedByAgentID),
  CONSTRAINT FKD0DAEB165327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKD0DAEB167699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKD0DAEB1678F036AA FOREIGN KEY (DnaSequencingRunID) REFERENCES dnasequencingrun (DNASequencingRunID),
  CONSTRAINT FKD0DAEB16C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table dnasequencingrun
--

DROP TABLE IF EXISTS dnasequencingrun;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE dnasequencingrun (
  DNASequencingRunID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  GeneSequence text,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  Number3 float(20,10) DEFAULT NULL,
  Ordinal int(11) DEFAULT NULL,
  PCRCocktailPrimer bit(1) DEFAULT NULL,
  PCRForwardPrimerCode varchar(32) DEFAULT NULL,
  PCRPrimerName varchar(32) DEFAULT NULL,
  PCRPrimerSequence5_3 varchar(64) DEFAULT NULL,
  PCRReversePrimerCode varchar(32) DEFAULT NULL,
  ReadDirection varchar(16) DEFAULT NULL,
  Remarks text,
  RunDate date DEFAULT NULL,
  ScoreFileName varchar(32) DEFAULT NULL,
  SequenceCocktailPrimer bit(1) DEFAULT NULL,
  SequencePrimerCode varchar(32) DEFAULT NULL,
  SequencePrimerName varchar(32) DEFAULT NULL,
  SequencePrimerSequence5_3 varchar(64) DEFAULT NULL,
  Text1 varchar(32) DEFAULT NULL,
  Text2 varchar(32) DEFAULT NULL,
  Text3 varchar(64) DEFAULT NULL,
  TraceFileName varchar(32) DEFAULT NULL,
  
  
  
  PreparedByAgentID int(11) DEFAULT NULL,
  
  RunByAgentID int(11) DEFAULT NULL,
  DNASequenceID int(11) NOT NULL,
  
  PRIMARY KEY (DNASequencingRunID),
  KEY FK2AF6F9D67699B003 (CreatedByAgentID),
  KEY FK2AF6F9D6D76CA4E (PreparedByAgentID),
  KEY FK2AF6F9D6851BDBC0 (RunByAgentID),
  KEY FK2AF6F9D65327F942 (ModifiedByAgentID),
  KEY FK2AF6F9D6265FB168 (DNASequenceID),
  CONSTRAINT FK2AF6F9D6265FB168 FOREIGN KEY (DNASequenceID) REFERENCES dnasequence (DnaSequenceID),
  CONSTRAINT FK2AF6F9D65327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK2AF6F9D67699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK2AF6F9D6851BDBC0 FOREIGN KEY (RunByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK2AF6F9D6D76CA4E FOREIGN KEY (PreparedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table dnasequencingruncitation
--

DROP TABLE IF EXISTS dnasequencingruncitation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE dnasequencingruncitation (
  DNASequencingRunCitationID int(11) NOT NULL AUTO_INCREMENT,

  

  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  Remarks text,
  Text1 text,
  Text2 text,
  
  
  ReferenceWorkID int(11) NOT NULL,
  
  DNASequencingRunID int(11) NOT NULL,
  
  PRIMARY KEY (DNASequencingRunCitationID),
  KEY FK24CEBD7699B003 (CreatedByAgentID),
  KEY FK24CEBD69734F30 (ReferenceWorkID),
  KEY FK24CEBD78F036AA (DNASequencingRunID),
  KEY FK24CEBD5327F942 (ModifiedByAgentID),
  CONSTRAINT FK24CEBD5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK24CEBD69734F30 FOREIGN KEY (ReferenceWorkID) REFERENCES referencework (ReferenceWorkID),
  CONSTRAINT FK24CEBD7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK24CEBD78F036AA FOREIGN KEY (DNASequencingRunID) REFERENCES dnasequencingrun (DNASequencingRunID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table exchangein
--

DROP TABLE IF EXISTS exchangein;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE exchangein (
  ExchangeInID int(11) NOT NULL AUTO_INCREMENT,

  

  Contents text,
  DescriptionOfMaterial varchar(120) DEFAULT NULL,
  ExchangeDate date DEFAULT NULL,
  ExchangeInNumber varchar(50) DEFAULT NULL,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  QuantityExchanged smallint(6) DEFAULT NULL,
  Remarks text,
  SrcGeography varchar(32) DEFAULT NULL,
  SrcTaxonomy varchar(32) DEFAULT NULL,
  Text1 text,
  Text2 text,
  
  
  
  ReceivedFromOrganizationID int(11) NOT NULL,
  DivisionID int(11) NOT NULL,
  
  CatalogedByID int(11) NOT NULL,
  AddressOfRecordID int(11) DEFAULT NULL,
  PRIMARY KEY (ExchangeInID),
  KEY DescriptionOfMaterialIDX (DescriptionOfMaterial),
  KEY ExchangeDateIDX (ExchangeDate),
  KEY FK366E9E887699B003 (CreatedByAgentID),
  KEY FK366E9E88DC8B4810 (AddressOfRecordID),
  KEY FK366E9E883824C16C (CatalogedByID),
  KEY FK366E9E88F77B069B (ReceivedFromOrganizationID),
  KEY FK366E9E8897C961D8 (DivisionID),
  KEY FK366E9E885327F942 (ModifiedByAgentID),
  CONSTRAINT FK366E9E885327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK366E9E883824C16C FOREIGN KEY (CatalogedByID) REFERENCES agent (AgentID),
  CONSTRAINT FK366E9E887699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK366E9E8897C961D8 FOREIGN KEY (DivisionID) REFERENCES division (UserGroupScopeId),
  CONSTRAINT FK366E9E88DC8B4810 FOREIGN KEY (AddressOfRecordID) REFERENCES addressofrecord (AddressOfRecordID),
  CONSTRAINT FK366E9E88F77B069B FOREIGN KEY (ReceivedFromOrganizationID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table exchangeinprep
--

DROP TABLE IF EXISTS exchangeinprep;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE exchangeinprep (
  ExchangeInPrepID int(11) NOT NULL AUTO_INCREMENT,

  

  Comments text,
  DescriptionOfMaterial varchar(255) DEFAULT NULL,
  Number1 int(11) DEFAULT NULL,
  Quantity int(11) DEFAULT NULL,
  Text1 text,
  Text2 text,
  DisciplineID int(11) NOT NULL,
  
  
  ExchangeInID int(11) DEFAULT NULL,
  PreparationID int(11) DEFAULT NULL,
  PRIMARY KEY (ExchangeInPrepID),
  KEY ExchgInPrepDspMemIDX (DisciplineID),
  KEY FK9A0BCB57699B003 (CreatedByAgentID),
  KEY FK9A0BCB51E18122E (ExchangeInID),
  KEY FK9A0BCB54CE675DE (DisciplineID),
  KEY FK9A0BCB518627F06 (PreparationID),
  KEY FK9A0BCB55327F942 (ModifiedByAgentID),
  CONSTRAINT FK9A0BCB55327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK9A0BCB518627F06 FOREIGN KEY (PreparationID) REFERENCES preparation (PreparationID),
  CONSTRAINT FK9A0BCB51E18122E FOREIGN KEY (ExchangeInID) REFERENCES exchangein (ExchangeInID),
  CONSTRAINT FK9A0BCB54CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK9A0BCB57699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table exchangeout
--

DROP TABLE IF EXISTS exchangeout;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE exchangeout (
  ExchangeOutID int(11) NOT NULL AUTO_INCREMENT,

  

  Contents text,
  DescriptionOfMaterial varchar(120) DEFAULT NULL,
  ExchangeDate date DEFAULT NULL,
  ExchangeOutNumber varchar(50) DEFAULT NULL,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  QuantityExchanged smallint(6) DEFAULT NULL,
  Remarks text,
  SrcGeography varchar(32) DEFAULT NULL,
  SrcTaxonomy varchar(32) DEFAULT NULL,
  Text1 text,
  Text2 text,
  
  
  CatalogedByID int(11) NOT NULL,
  SentToOrganizationID int(11) NOT NULL,
  DivisionID int(11) NOT NULL,
  
  AddressOfRecordID int(11) DEFAULT NULL,
  
  PRIMARY KEY (ExchangeOutID),
  KEY DescriptionOfMaterialIDX2 (DescriptionOfMaterial),
  KEY ExchangeOutdateIDX (ExchangeDate),
  KEY FK97654A4B7699B003 (CreatedByAgentID),
  KEY FK97654A4BDC8B4810 (AddressOfRecordID),
  KEY FK97654A4B3824C16C (CatalogedByID),
  KEY FK97654A4B97C961D8 (DivisionID),
  KEY FK97654A4BA21647A3 (SentToOrganizationID),
  KEY FK97654A4B5327F942 (ModifiedByAgentID),
  CONSTRAINT FK97654A4B5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK97654A4B3824C16C FOREIGN KEY (CatalogedByID) REFERENCES agent (AgentID),
  CONSTRAINT FK97654A4B7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK97654A4B97C961D8 FOREIGN KEY (DivisionID) REFERENCES division (UserGroupScopeId),
  CONSTRAINT FK97654A4BA21647A3 FOREIGN KEY (SentToOrganizationID) REFERENCES agent (AgentID),
  CONSTRAINT FK97654A4BDC8B4810 FOREIGN KEY (AddressOfRecordID) REFERENCES addressofrecord (AddressOfRecordID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table exchangeoutprep
--

DROP TABLE IF EXISTS exchangeoutprep;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE exchangeoutprep (
  ExchangeOutPrepID int(11) NOT NULL AUTO_INCREMENT,

  

  Comments text,
  DescriptionOfMaterial varchar(255) DEFAULT NULL,
  Number1 int(11) DEFAULT NULL,
  Quantity int(11) DEFAULT NULL,
  Text1 text,
  Text2 text,
  
  
  ExchangeOutID int(11) DEFAULT NULL,
  DisciplineID int(11) NOT NULL,
  PreparationID int(11) DEFAULT NULL,
  PRIMARY KEY (ExchangeOutPrepID),
  KEY ExchgOutPrepDspMemIDX (DisciplineID),
  KEY FK7405CEF87699B003 (CreatedByAgentID),
  KEY FK7405CEF84CE675DE (DisciplineID),
  KEY FK7405CEF818627F06 (PreparationID),
  KEY FK7405CEF8A542314E (ExchangeOutID),
  KEY FK7405CEF85327F942 (ModifiedByAgentID),
  CONSTRAINT FK7405CEF85327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK7405CEF818627F06 FOREIGN KEY (PreparationID) REFERENCES preparation (PreparationID),
  CONSTRAINT FK7405CEF84CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK7405CEF87699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK7405CEF8A542314E FOREIGN KEY (ExchangeOutID) REFERENCES exchangeout (ExchangeOutID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table exsiccata
--

DROP TABLE IF EXISTS exsiccata;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE exsiccata (
  ExsiccataID int(11) NOT NULL AUTO_INCREMENT,

  

  Title varchar(255) NOT NULL,
  
  ReferenceWorkID int(11) NOT NULL,
  
  PRIMARY KEY (ExsiccataID),
  KEY FKACC7DD857699B003 (CreatedByAgentID),
  KEY FKACC7DD8569734F30 (ReferenceWorkID),
  KEY FKACC7DD855327F942 (ModifiedByAgentID),
  CONSTRAINT FKACC7DD855327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKACC7DD8569734F30 FOREIGN KEY (ReferenceWorkID) REFERENCES referencework (ReferenceWorkID),
  CONSTRAINT FKACC7DD857699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table exsiccataitem
--

DROP TABLE IF EXISTS exsiccataitem;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE exsiccataitem (
  ExsiccataItemID int(11) NOT NULL AUTO_INCREMENT,

  

  Fascicle varchar(16) DEFAULT NULL,
  Number varchar(16) DEFAULT NULL,
  
  
  CollectionObjectID int(11) NOT NULL,
  ExsiccataID int(11) NOT NULL,
  PRIMARY KEY (ExsiccataItemID),
  KEY FK23150E187699B003 (CreatedByAgentID),
  KEY FK23150E1875E37458 (CollectionObjectID),
  KEY FK23150E183B4364A2 (ExsiccataID),
  KEY FK23150E185327F942 (ModifiedByAgentID),
  CONSTRAINT FK23150E185327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK23150E183B4364A2 FOREIGN KEY (ExsiccataID) REFERENCES exsiccata (ExsiccataID),
  CONSTRAINT FK23150E1875E37458 FOREIGN KEY (CollectionObjectID) REFERENCES collectionobject (CollectionObjectID),
  CONSTRAINT FK23150E187699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table fieldnotebook
--

DROP TABLE IF EXISTS fieldnotebook;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE fieldnotebook (
  FieldNotebookID int(11) NOT NULL AUTO_INCREMENT,

  

  Description text,
  EndDate date DEFAULT NULL,
  Storage varchar(64) DEFAULT NULL,
  Name varchar(32) DEFAULT NULL,
  StartDate date DEFAULT NULL,
  AgentID int(11) NOT NULL,
  DisciplineID int(11) NOT NULL,
  
  CollectionID int(11) NOT NULL,
  
  PRIMARY KEY (FieldNotebookID),
  KEY FNBEndDateIDX (EndDate),
  KEY FNBNameIDX (Name),
  KEY FNBStartDateIDX (StartDate),
  KEY FK4647A8D57699B003 (CreatedByAgentID),
  KEY FK4647A8D5384B3622 (AgentID),
  KEY FK4647A8D54CE675DE (DisciplineID),
  KEY FK4647A8D58C2288BA (CollectionID),
  KEY FK4647A8D55327F942 (ModifiedByAgentID),
  CONSTRAINT FK4647A8D55327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK4647A8D5384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK4647A8D54CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK4647A8D57699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK4647A8D58C2288BA FOREIGN KEY (CollectionID) REFERENCES collection (UserGroupScopeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table fieldnotebookattachment
--

DROP TABLE IF EXISTS fieldnotebookattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE fieldnotebookattachment (
  FieldNotebookAttachmentId int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  
  FieldNotebookID int(11) NOT NULL,
  
  AttachmentID int(11) NOT NULL,
  PRIMARY KEY (FieldNotebookAttachmentId),
  KEY FKDC15BBB87699B003 (CreatedByAgentID),
  KEY FKDC15BBB8B522A4E2 (FieldNotebookID),
  KEY FKDC15BBB8C7E55084 (AttachmentID),
  KEY FKDC15BBB85327F942 (ModifiedByAgentID),
  CONSTRAINT FKDC15BBB85327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKDC15BBB87699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKDC15BBB8B522A4E2 FOREIGN KEY (FieldNotebookID) REFERENCES fieldnotebook (FieldNotebookID),
  CONSTRAINT FKDC15BBB8C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table fieldnotebookpage
--

DROP TABLE IF EXISTS fieldnotebookpage;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE fieldnotebookpage (
  FieldNotebookPageID int(11) NOT NULL AUTO_INCREMENT,

  

  Description varchar(128) DEFAULT NULL,
  PageNumber varchar(32) NOT NULL,
  ScanDate date DEFAULT NULL,
  DisciplineID int(11) NOT NULL,
  
  FieldNotebookPageSetID int(11) DEFAULT NULL,
  
  PRIMARY KEY (FieldNotebookPageID),
  KEY FNBPPageNumberIDX (PageNumber),
  KEY FNBPScanDateIDX (ScanDate),
  KEY FK162198E47699B003 (CreatedByAgentID),
  KEY FK162198E44CE675DE (DisciplineID),
  KEY FK162198E49B34BD5A (FieldNotebookPageSetID),
  KEY FK162198E45327F942 (ModifiedByAgentID),
  CONSTRAINT FK162198E45327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK162198E44CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK162198E47699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK162198E49B34BD5A FOREIGN KEY (FieldNotebookPageSetID) REFERENCES fieldnotebookpageset (FieldNotebookPageSetID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table fieldnotebookpageattachment
--

DROP TABLE IF EXISTS fieldnotebookpageattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE fieldnotebookpageattachment (
  FieldNotebookPageAttachmentId int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  FieldNotebookPageID int(11) NOT NULL,
  
  
  AttachmentID int(11) NOT NULL,
  PRIMARY KEY (FieldNotebookPageAttachmentId),
  KEY FK91AA25077699B003 (CreatedByAgentID),
  KEY FK91AA250773BF3AE0 (FieldNotebookPageID),
  KEY FK91AA2507C7E55084 (AttachmentID),
  KEY FK91AA25075327F942 (ModifiedByAgentID),
  CONSTRAINT FK91AA25075327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK91AA250773BF3AE0 FOREIGN KEY (FieldNotebookPageID) REFERENCES fieldnotebookpage (FieldNotebookPageID),
  CONSTRAINT FK91AA25077699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK91AA2507C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table fieldnotebookpageset
--

DROP TABLE IF EXISTS fieldnotebookpageset;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE fieldnotebookpageset (
  FieldNotebookPageSetID int(11) NOT NULL AUTO_INCREMENT,

  

  Description varchar(128) DEFAULT NULL,
  EndDate date DEFAULT NULL,
  Method varchar(64) DEFAULT NULL,
  OrderNumber smallint(6) DEFAULT NULL,
  StartDate date DEFAULT NULL,
  
  DisciplineID int(11) NOT NULL,
  
  AgentID int(11) DEFAULT NULL,
  FieldNotebookID int(11) DEFAULT NULL,
  PRIMARY KEY (FieldNotebookPageSetID),
  KEY FNBPSStartDateIDX (StartDate),
  KEY FNBPSEndDateIDX (EndDate),
  KEY FK6FC0C8FE7699B003 (CreatedByAgentID),
  KEY FK6FC0C8FEB522A4E2 (FieldNotebookID),
  KEY FK6FC0C8FE384B3622 (AgentID),
  KEY FK6FC0C8FE4CE675DE (DisciplineID),
  KEY FK6FC0C8FE5327F942 (ModifiedByAgentID),
  CONSTRAINT FK6FC0C8FE5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK6FC0C8FE384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK6FC0C8FE4CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK6FC0C8FE7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK6FC0C8FEB522A4E2 FOREIGN KEY (FieldNotebookID) REFERENCES fieldnotebook (FieldNotebookID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table fieldnotebookpagesetattachment
--

DROP TABLE IF EXISTS fieldnotebookpagesetattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE fieldnotebookpagesetattachment (
  FieldNotebookPageSetAttachmentId int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  FieldNotebookPageSetID int(11) NOT NULL,
  
  
  AttachmentID int(11) NOT NULL,
  PRIMARY KEY (FieldNotebookPageSetAttachmentId),
  KEY FKB1477CA17699B003 (CreatedByAgentID),
  KEY FKB1477CA19B34BD5A (FieldNotebookPageSetID),
  KEY FKB1477CA1C7E55084 (AttachmentID),
  KEY FKB1477CA15327F942 (ModifiedByAgentID),
  CONSTRAINT FKB1477CA15327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKB1477CA17699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKB1477CA19B34BD5A FOREIGN KEY (FieldNotebookPageSetID) REFERENCES fieldnotebookpageset (FieldNotebookPageSetID),
  CONSTRAINT FKB1477CA1C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table fundingagent
--

DROP TABLE IF EXISTS fundingagent;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE fundingagent (
  FundingAgentID int(11) NOT NULL AUTO_INCREMENT,

  

  IsPrimary bit(1) NOT NULL,
  OrderNumber int(11) NOT NULL,
  Remarks text,
  Type varchar(32) DEFAULT NULL,
  AgentID int(11) NOT NULL,
  
  CollectingTripID int(11) NOT NULL,
  
  DivisionID int(11) DEFAULT NULL,
  PRIMARY KEY (FundingAgentID),
  UNIQUE KEY AgentID (AgentID,CollectingTripID),
  KEY COLTRIPDivIDX (DivisionID),
  KEY FKB2AD6287699B003 (CreatedByAgentID),
  KEY FKB2AD628384B3622 (AgentID),
  KEY FKB2AD628697B3F98 (CollectingTripID),
  KEY FKB2AD62897C961D8 (DivisionID),
  KEY FKB2AD6285327F942 (ModifiedByAgentID),
  CONSTRAINT FKB2AD6285327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKB2AD628384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKB2AD628697B3F98 FOREIGN KEY (CollectingTripID) REFERENCES collectingtrip (CollectingTripID),
  CONSTRAINT FKB2AD6287699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKB2AD62897C961D8 FOREIGN KEY (DivisionID) REFERENCES division (UserGroupScopeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table geocoorddetail
--

DROP TABLE IF EXISTS geocoorddetail;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE geocoorddetail (
  GeoCoordDetailID int(11) NOT NULL AUTO_INCREMENT,

  

  ErrorPolygon text,
  GeoRefAccuracy double DEFAULT NULL,
  GeoRefAccuracyUnits varchar(20) DEFAULT NULL,
  GeoRefDetDate datetime DEFAULT NULL,
  GeoRefDetRef varchar(100) DEFAULT NULL,
  GeoRefRemarks text,
  GeoRefVerificationStatus varchar(50) DEFAULT NULL,
  MaxUncertaintyEst decimal(20,10) DEFAULT NULL,
  MaxUncertaintyEstUnit varchar(8) DEFAULT NULL,
  NamedPlaceExtent decimal(20,10) DEFAULT NULL,
  NoGeoRefBecause varchar(100) DEFAULT NULL,
  OriginalCoordSystem varchar(32) DEFAULT NULL,
  Protocol varchar(64) DEFAULT NULL,
  Source varchar(64) DEFAULT NULL,
  Text1 text,
  Text2 text,
  Text3 text,
  UncertaintyPolygon text,
  Validation varchar(64) DEFAULT NULL,
  AgentID int(11) DEFAULT NULL,
  
  
  LocalityID int(11) DEFAULT NULL,
  PRIMARY KEY (GeoCoordDetailID),
  KEY FKB688EB957699B003 (CreatedByAgentID),
  KEY FKB688EB95384B3622 (AgentID),
  KEY FKB688EB95A666A5C4 (LocalityID),
  KEY FKB688EB955327F942 (ModifiedByAgentID),
  CONSTRAINT FKB688EB955327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKB688EB95384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKB688EB957699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKB688EB95A666A5C4 FOREIGN KEY (LocalityID) REFERENCES locality (LocalityID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table gift
--

DROP TABLE IF EXISTS gift;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE gift (
  GiftID int(11) NOT NULL AUTO_INCREMENT,

  

  Contents text,
  DateReceived date DEFAULT NULL,
  GiftDate date DEFAULT NULL,
  GiftNumber varchar(50) NOT NULL,
  IsFinancialResponsibility bit(1) DEFAULT NULL,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  PurposeOfGift varchar(64) DEFAULT NULL,
  ReceivedComments varchar(255) DEFAULT NULL,
  Remarks text,
  SpecialConditions text,
  SrcGeography varchar(500) DEFAULT NULL,
  SrcTaxonomy varchar(500) DEFAULT NULL,
  Text1 text,
  Text2 text,
  
  
  DivisionID int(11) DEFAULT NULL,
  DisciplineID int(11) NOT NULL,
  AddressOfRecordID int(11) DEFAULT NULL,
  
  
  PRIMARY KEY (GiftID),
  KEY GiftDateIDX (GiftDate),
  KEY GiftNumberIDX (GiftNumber),
  KEY FK3069307699B003 (CreatedByAgentID),
  KEY FK306930DC8B4810 (AddressOfRecordID),
  KEY FK3069304CE675DE (DisciplineID),
  KEY FK30693097C961D8 (DivisionID),
  KEY FK3069305327F942 (ModifiedByAgentID),
  CONSTRAINT FK3069305327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK3069304CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK3069307699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK30693097C961D8 FOREIGN KEY (DivisionID) REFERENCES division (UserGroupScopeId),
  CONSTRAINT FK306930DC8B4810 FOREIGN KEY (AddressOfRecordID) REFERENCES addressofrecord (AddressOfRecordID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table giftagent
--

DROP TABLE IF EXISTS giftagent;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE giftagent (
  GiftAgentID int(11) NOT NULL AUTO_INCREMENT,

  

  Remarks text,
  Role varchar(50) NOT NULL,
  DisciplineID int(11) NOT NULL,
  GiftID int(11) NOT NULL,
  
  AgentID int(11) NOT NULL,
  
  PRIMARY KEY (GiftAgentID),
  UNIQUE KEY Role (Role,GiftID,AgentID),
  KEY GiftAgDspMemIDX (DisciplineID),
  KEY FK221917D57699B003 (CreatedByAgentID),
  KEY FK221917D59890879E (GiftID),
  KEY FK221917D5384B3622 (AgentID),
  KEY FK221917D54CE675DE (DisciplineID),
  KEY FK221917D55327F942 (ModifiedByAgentID),
  CONSTRAINT FK221917D55327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK221917D5384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK221917D54CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK221917D57699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK221917D59890879E FOREIGN KEY (GiftID) REFERENCES gift (GiftID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table giftattachment
--

DROP TABLE IF EXISTS giftattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE giftattachment (
  GiftAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  GiftID int(11) NOT NULL,
  AttachmentID int(11) NOT NULL,
  
  
  PRIMARY KEY (GiftAttachmentID),
  KEY FKC75A06537699B003 (CreatedByAgentID),
  KEY FKC75A06539890879E (GiftID),
  KEY FKC75A0653C7E55084 (AttachmentID),
  KEY FKC75A06535327F942 (ModifiedByAgentID),
  CONSTRAINT FKC75A06535327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKC75A06537699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKC75A06539890879E FOREIGN KEY (GiftID) REFERENCES gift (GiftID),
  CONSTRAINT FKC75A0653C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table giftpreparation
--

DROP TABLE IF EXISTS giftpreparation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE giftpreparation (
  GiftPreparationID int(11) NOT NULL AUTO_INCREMENT,

  

  DescriptionOfMaterial varchar(255) DEFAULT NULL,
  InComments text,
  OutComments text,
  Quantity int(11) DEFAULT NULL,
  ReceivedComments text,
  PreparationID int(11) DEFAULT NULL,
  DisciplineID int(11) NOT NULL,
  
  GiftID int(11) DEFAULT NULL,
  
  PRIMARY KEY (GiftPreparationID),
  KEY GiftPrepDspMemIDX (DisciplineID),
  KEY FK18B1F677699B003 (CreatedByAgentID),
  KEY FK18B1F679890879E (GiftID),
  KEY FK18B1F674CE675DE (DisciplineID),
  KEY FK18B1F6718627F06 (PreparationID),
  KEY FK18B1F675327F942 (ModifiedByAgentID),
  CONSTRAINT FK18B1F675327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK18B1F6718627F06 FOREIGN KEY (PreparationID) REFERENCES preparation (PreparationID),
  CONSTRAINT FK18B1F674CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK18B1F677699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK18B1F679890879E FOREIGN KEY (GiftID) REFERENCES gift (GiftID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table groupperson
--

DROP TABLE IF EXISTS groupperson;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE groupperson (
  GroupPersonID int(11) NOT NULL AUTO_INCREMENT,

  

  OrderNumber smallint(6) NOT NULL,
  Remarks text,
  
  MemberID int(11) NOT NULL,
  
  GroupID int(11) NOT NULL,
  DivisionID int(11) NOT NULL,
  PRIMARY KEY (GroupPersonID),
  UNIQUE KEY OrderNumber (OrderNumber,GroupID),
  KEY FK5DEB76947699B003 (CreatedByAgentID),
  KEY FK5DEB76948905F31C (GroupID),
  KEY FK5DEB769497C961D8 (DivisionID),
  KEY FK5DEB76945327F942 (ModifiedByAgentID),
  KEY FK5DEB769450D2EC77 (MemberID),
  CONSTRAINT FK5DEB769450D2EC77 FOREIGN KEY (MemberID) REFERENCES agent (AgentID),
  CONSTRAINT FK5DEB76945327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK5DEB76947699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK5DEB76948905F31C FOREIGN KEY (GroupID) REFERENCES agent (AgentID),
  CONSTRAINT FK5DEB769497C961D8 FOREIGN KEY (DivisionID) REFERENCES division (UserGroupScopeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table hibernate_unique_key
--

DROP TABLE IF EXISTS hibernate_unique_key;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE hibernate_unique_key (
  next_hi int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table inforequest
--

DROP TABLE IF EXISTS inforequest;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE inforequest (
  InfoRequestID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  Email varchar(50) DEFAULT NULL,
  Firstname varchar(50) DEFAULT NULL,
  InfoReqNumber varchar(32) DEFAULT NULL,
  Institution varchar(127) DEFAULT NULL,
  Lastname varchar(50) DEFAULT NULL,
  Remarks text,
  ReplyDate date DEFAULT NULL,
  RequestDate date DEFAULT NULL,
  AgentID int(11) DEFAULT NULL,
  
  
  PRIMARY KEY (InfoRequestID),
  KEY IRColMemIDX (CollectionMemberID),
  KEY FK68918E217699B003 (CreatedByAgentID),
  KEY FK68918E21384B3622 (AgentID),
  KEY FK68918E215327F942 (ModifiedByAgentID),
  CONSTRAINT FK68918E215327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK68918E21384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK68918E217699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table institution
--

DROP TABLE IF EXISTS institution;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE institution (
  UserGroupScopeId int(11) NOT NULL,

  

  
  
  AltName varchar(128) DEFAULT NULL,
  Code varchar(64) DEFAULT NULL,
  Copyright text,
  CurrentManagedRelVersion varchar(8) DEFAULT NULL,
  CurrentManagedSchemaVersion varchar(8) DEFAULT NULL,
  Description text,
  Disclaimer text,
  GUID varchar(128) DEFAULT NULL,
  HasBeenAsked bit(1) DEFAULT NULL,
  IconURI varchar(255) DEFAULT NULL,
  institutionId int(11) DEFAULT NULL,
  Ipr text,
  IsAccessionsGlobal bit(1) NOT NULL,
  IsAnonymous bit(1) DEFAULT NULL,
  IsReleaseManagedGlobally bit(1) DEFAULT NULL,
  IsSecurityOn bit(1) NOT NULL,
  IsServerBased bit(1) NOT NULL,
  IsSharingLocalities bit(1) NOT NULL,
  IsSingleGeographyTree bit(1) NOT NULL,
  License text,
  LsidAuthority varchar(64) DEFAULT NULL,
  MinimumPwdLength tinyint(4) DEFAULT NULL,
  Name varchar(255) DEFAULT NULL,
  RegNumber varchar(24) DEFAULT NULL,
  Remarks text,
  TermsOfUse text,
  Uri varchar(255) DEFAULT NULL,
  AddressID int(11) DEFAULT NULL,
  StorageTreeDefID int(11) DEFAULT NULL,
  PRIMARY KEY (UserGroupScopeId),
  KEY InstNameIDX (Name),
  KEY InstGuidIDX (GUID),
  KEY FK3D0021607699B0033529a5b8 (CreatedByAgentID),
  KEY FK3529A5B853C7EFD6 (StorageTreeDefID),
  KEY FK3529A5B8E6A64D00 (AddressID),
  KEY FK3D0021605327F9423529a5b8 (ModifiedByAgentID),
  CONSTRAINT FK3D0021605327F9423529a5b8 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK3529A5B853C7EFD6 FOREIGN KEY (StorageTreeDefID) REFERENCES storagetreedef (StorageTreeDefID),
  CONSTRAINT FK3529A5B8E6A64D00 FOREIGN KEY (AddressID) REFERENCES address (AddressID),
  CONSTRAINT FK3D0021607699B0033529a5b8 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table institutionnetwork
--

DROP TABLE IF EXISTS institutionnetwork;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE institutionnetwork (
  InstitutionNetworkID int(11) NOT NULL AUTO_INCREMENT,

  

  AltName varchar(128) DEFAULT NULL,
  Code varchar(64) DEFAULT NULL,
  Copyright text,
  Description text,
  Disclaimer text,
  IconURI varchar(255) DEFAULT NULL,
  Ipr text,
  License text,
  Name varchar(255) DEFAULT NULL,
  Remarks text,
  TermsOfUse text,
  Uri varchar(255) DEFAULT NULL,
  AddressID int(11) DEFAULT NULL,
  
  
  PRIMARY KEY (InstitutionNetworkID),
  KEY InstNetworkNameIDX (Name),
  KEY FK945C55767699B003 (CreatedByAgentID),
  KEY FK945C5576E6A64D00 (AddressID),
  KEY FK945C55765327F942 (ModifiedByAgentID),
  CONSTRAINT FK945C55765327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK945C55767699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK945C5576E6A64D00 FOREIGN KEY (AddressID) REFERENCES address (AddressID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table journal
--

DROP TABLE IF EXISTS journal;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE journal (
  JournalID int(11) NOT NULL AUTO_INCREMENT,

  

  GUID varchar(128) DEFAULT NULL,
  ISSN varchar(16) DEFAULT NULL,
  JournalAbbreviation varchar(50) DEFAULT NULL,
  JournalName varchar(255) DEFAULT NULL,
  Remarks text,
  Text1 varchar(32) DEFAULT NULL,
  
  
  InstitutionID int(11) NOT NULL,
  PRIMARY KEY (JournalID),
  KEY JournalNameIDX (JournalName),
  KEY JournalGUIDIDX (GUID),
  KEY FKAB64AF377699B003 (CreatedByAgentID),
  KEY FKAB64AF3781223908 (InstitutionID),
  KEY FKAB64AF375327F942 (ModifiedByAgentID),
  CONSTRAINT FKAB64AF375327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKAB64AF377699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKAB64AF3781223908 FOREIGN KEY (InstitutionID) REFERENCES institution (UserGroupScopeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table latlonpolygon
--

DROP TABLE IF EXISTS latlonpolygon;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE latlonpolygon (
  LatLonPolygonID int(11) NOT NULL AUTO_INCREMENT,

  

  Description text,
  IsPolyline bit(1) NOT NULL,
  Name varchar(64) NOT NULL,
  LocalityID int(11) DEFAULT NULL,
  SpVisualQueryID int(11) DEFAULT NULL,
  
  
  PRIMARY KEY (LatLonPolygonID),
  KEY FKE4EEDE6E7699B003 (CreatedByAgentID),
  KEY FKE4EEDE6E2583AF6E (SpVisualQueryID),
  KEY FKE4EEDE6EA666A5C4 (LocalityID),
  KEY FKE4EEDE6E5327F942 (ModifiedByAgentID),
  CONSTRAINT FKE4EEDE6E5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKE4EEDE6E2583AF6E FOREIGN KEY (SpVisualQueryID) REFERENCES spvisualquery (SpVisualQueryID),
  CONSTRAINT FKE4EEDE6E7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKE4EEDE6EA666A5C4 FOREIGN KEY (LocalityID) REFERENCES locality (LocalityID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table latlonpolygonpnt
--

DROP TABLE IF EXISTS latlonpolygonpnt;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE latlonpolygonpnt (
  LatLonPolygonPntID int(11) NOT NULL AUTO_INCREMENT,
  Elevation int(11) DEFAULT NULL,
  Latitude decimal(12,10) NOT NULL,
  Longitude decimal(12,10) NOT NULL,
  Ordinal int(11) NOT NULL,
  LatLonPolygonID int(11) NOT NULL,
  PRIMARY KEY (LatLonPolygonPntID),
  KEY FK31701508BBAA1DB4 (LatLonPolygonID),
  CONSTRAINT FK31701508BBAA1DB4 FOREIGN KEY (LatLonPolygonID) REFERENCES latlonpolygon (LatLonPolygonID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table lithostrat
--

DROP TABLE IF EXISTS lithostrat;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE lithostrat (
  LithoStratID int(11) NOT NULL AUTO_INCREMENT,

  

  FullName varchar(255) DEFAULT NULL,
  GUID varchar(128) DEFAULT NULL,
  HighestChildNodeNumber int(11) DEFAULT NULL,
  IsAccepted bit(1) NOT NULL,
  Name varchar(64) NOT NULL,
  NodeNumber int(11) DEFAULT NULL,
  Number1 double DEFAULT NULL,
  Number2 double DEFAULT NULL,
  RankID int(11) NOT NULL,
  Remarks text,
  Text1 text,
  Text2 text,
  
  
  
  
  AcceptedID int(11) DEFAULT NULL,
  LithoStratTreeDefID int(11) NOT NULL,
  LithoStratTreeDefItemID int(11) NOT NULL,
  ParentID int(11) DEFAULT NULL,
  PRIMARY KEY (LithoStratID),
  KEY LithoNameIDX (Name),
  KEY LithoFullNameIDX (FullName),
  KEY LithoGuidIDX (GUID),
  KEY FK329297067699B003 (CreatedByAgentID),
  KEY FK329297067A1D53CB (AcceptedID),
  KEY FK3292970699E26740 (LithoStratTreeDefItemID),
  KEY FK3292970672939D3A (LithoStratTreeDefID),
  KEY FK32929706943880E (ParentID),
  KEY FK329297065327F942 (ModifiedByAgentID),
  CONSTRAINT FK329297065327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK3292970672939D3A FOREIGN KEY (LithoStratTreeDefID) REFERENCES lithostrattreedef (LithoStratTreeDefID),
  CONSTRAINT FK329297067699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK329297067A1D53CB FOREIGN KEY (AcceptedID) REFERENCES lithostrat (LithoStratID),
  CONSTRAINT FK32929706943880E FOREIGN KEY (ParentID) REFERENCES lithostrat (LithoStratID),
  CONSTRAINT FK3292970699E26740 FOREIGN KEY (LithoStratTreeDefItemID) REFERENCES lithostrattreedefitem (LithoStratTreeDefItemID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table lithostrattreedef
--

DROP TABLE IF EXISTS lithostrattreedef;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE lithostrattreedef (
  LithoStratTreeDefID int(11) NOT NULL AUTO_INCREMENT,

  

  FullNameDirection int(11) DEFAULT NULL,
  Name varchar(64) NOT NULL,
  Remarks text,
  
  
  PRIMARY KEY (LithoStratTreeDefID),
  KEY FK268699E17699B003 (CreatedByAgentID),
  KEY FK268699E15327F942 (ModifiedByAgentID),
  CONSTRAINT FK268699E15327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK268699E17699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table lithostrattreedefitem
--

DROP TABLE IF EXISTS lithostrattreedefitem;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE lithostrattreedefitem (
  LithoStratTreeDefItemID int(11) NOT NULL AUTO_INCREMENT,

  

  FullNameSeparator varchar(32) DEFAULT NULL,
  IsEnforced bit(1) DEFAULT NULL,
  IsInFullName bit(1) DEFAULT NULL,
  Name varchar(64) NOT NULL,
  RankID int(11) NOT NULL,
  Remarks text,
  TextAfter varchar(64) DEFAULT NULL,
  TextBefore varchar(64) DEFAULT NULL,
  Title varchar(64) DEFAULT NULL,
  ParentItemID int(11) DEFAULT NULL,
  
  
  LithoStratTreeDefID int(11) NOT NULL,
  PRIMARY KEY (LithoStratTreeDefItemID),
  KEY FKEC263C747699B003 (CreatedByAgentID),
  KEY FKEC263C7472939D3A (LithoStratTreeDefID),
  KEY FKEC263C748340DB49 (ParentItemID),
  KEY FKEC263C745327F942 (ModifiedByAgentID),
  CONSTRAINT FKEC263C745327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKEC263C7472939D3A FOREIGN KEY (LithoStratTreeDefID) REFERENCES lithostrattreedef (LithoStratTreeDefID),
  CONSTRAINT FKEC263C747699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKEC263C748340DB49 FOREIGN KEY (ParentItemID) REFERENCES lithostrattreedefitem (LithoStratTreeDefItemID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table loan
--

DROP TABLE IF EXISTS loan;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE loan (
  LoanID int(11) NOT NULL AUTO_INCREMENT,

  

  Contents text,
  CurrentDueDate date DEFAULT NULL,
  DateClosed date DEFAULT NULL,
  DateReceived date DEFAULT NULL,
  IsClosed bit(1) DEFAULT NULL,
  IsFinancialResponsibility bit(1) DEFAULT NULL,
  LoanDate date DEFAULT NULL,
  LoanNumber varchar(50) NOT NULL,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  OriginalDueDate date DEFAULT NULL,
  OverdueNotiSetDate date DEFAULT NULL,
  PurposeOfLoan varchar(64) DEFAULT NULL,
  ReceivedComments varchar(255) DEFAULT NULL,
  Remarks text,
  SpecialConditions text,
  SrcGeography varchar(500) DEFAULT NULL,
  SrcTaxonomy varchar(500) DEFAULT NULL,
  Text1 text,
  Text2 text,
  
  
  DisciplineID int(11) NOT NULL,
  DivisionID int(11) DEFAULT NULL,
  
  AddressOfRecordID int(11) DEFAULT NULL,
  
  PRIMARY KEY (LoanID),
  KEY LoanDateIDX (LoanDate),
  KEY LoanNumberIDX (LoanNumber),
  KEY CurrentDueDateIDX (CurrentDueDate),
  KEY FK32C4F07699B003 (CreatedByAgentID),
  KEY FK32C4F0DC8B4810 (AddressOfRecordID),
  KEY FK32C4F04CE675DE (DisciplineID),
  KEY FK32C4F097C961D8 (DivisionID),
  KEY FK32C4F05327F942 (ModifiedByAgentID),
  CONSTRAINT FK32C4F05327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK32C4F04CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK32C4F07699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK32C4F097C961D8 FOREIGN KEY (DivisionID) REFERENCES division (UserGroupScopeId),
  CONSTRAINT FK32C4F0DC8B4810 FOREIGN KEY (AddressOfRecordID) REFERENCES addressofrecord (AddressOfRecordID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table loanagent
--

DROP TABLE IF EXISTS loanagent;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE loanagent (
  LoanAgentID int(11) NOT NULL AUTO_INCREMENT,

  

  Remarks text,
  Role varchar(50) NOT NULL,
  DisciplineID int(11) NOT NULL,
  
  LoanID int(11) NOT NULL,
  
  AgentID int(11) NOT NULL,
  PRIMARY KEY (LoanAgentID),
  UNIQUE KEY Role (Role,LoanID,AgentID),
  KEY LoanAgDspMemIDX (DisciplineID),
  KEY FK63FA14157699B003 (CreatedByAgentID),
  KEY FK63FA1415384B3622 (AgentID),
  KEY FK63FA14154CE675DE (DisciplineID),
  KEY FK63FA1415A16D4F1E (LoanID),
  KEY FK63FA14155327F942 (ModifiedByAgentID),
  CONSTRAINT FK63FA14155327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK63FA1415384B3622 FOREIGN KEY (AgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK63FA14154CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK63FA14157699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK63FA1415A16D4F1E FOREIGN KEY (LoanID) REFERENCES loan (LoanID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table loanattachment
--

DROP TABLE IF EXISTS loanattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE loanattachment (
  LoanAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  
  LoanID int(11) NOT NULL,
  
  AttachmentID int(11) NOT NULL,
  PRIMARY KEY (LoanAttachmentID),
  KEY FK23ECB2137699B003 (CreatedByAgentID),
  KEY FK23ECB213C7E55084 (AttachmentID),
  KEY FK23ECB213A16D4F1E (LoanID),
  KEY FK23ECB2135327F942 (ModifiedByAgentID),
  CONSTRAINT FK23ECB2135327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK23ECB2137699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK23ECB213A16D4F1E FOREIGN KEY (LoanID) REFERENCES loan (LoanID),
  CONSTRAINT FK23ECB213C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table loanpreparation
--

DROP TABLE IF EXISTS loanpreparation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE loanpreparation (
  LoanPreparationID int(11) NOT NULL AUTO_INCREMENT,

  

  DescriptionOfMaterial varchar(255) DEFAULT NULL,
  InComments text,
  IsResolved bit(1) NOT NULL,
  OutComments text,
  Quantity int(11) DEFAULT NULL,
  QuantityResolved int(11) DEFAULT NULL,
  QuantityReturned int(11) DEFAULT NULL,
  ReceivedComments text,
  
  PreparationID int(11) DEFAULT NULL,
  LoanID int(11) NOT NULL,
  DisciplineID int(11) NOT NULL,
  
  PRIMARY KEY (LoanPreparationID),
  KEY LoanPrepDspMemIDX (DisciplineID),
  KEY FK374DEBA77699B003 (CreatedByAgentID),
  KEY FK374DEBA74CE675DE (DisciplineID),
  KEY FK374DEBA718627F06 (PreparationID),
  KEY FK374DEBA7A16D4F1E (LoanID),
  KEY FK374DEBA75327F942 (ModifiedByAgentID),
  CONSTRAINT FK374DEBA75327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK374DEBA718627F06 FOREIGN KEY (PreparationID) REFERENCES preparation (PreparationID),
  CONSTRAINT FK374DEBA74CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK374DEBA77699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK374DEBA7A16D4F1E FOREIGN KEY (LoanID) REFERENCES loan (LoanID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table loanreturnpreparation
--

DROP TABLE IF EXISTS loanreturnpreparation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE loanreturnpreparation (
  LoanReturnPreparationID int(11) NOT NULL AUTO_INCREMENT,

  

  QuantityResolved int(11) DEFAULT NULL,
  QuantityReturned int(11) DEFAULT NULL,
  Remarks text,
  ReturnedDate date DEFAULT NULL,
  ReceivedByID int(11) DEFAULT NULL,
  DisciplineID int(11) NOT NULL,
  
  DeaccessionPreparationID int(11) DEFAULT NULL,
  LoanPreparationID int(11) NOT NULL,
  
  PRIMARY KEY (LoanReturnPreparationID),
  KEY LoanReturnedDateIDX (ReturnedDate),
  KEY LoanRetPrepDspMemIDX (DisciplineID),
  KEY FK363284777699B003 (CreatedByAgentID),
  KEY FK3632847749C90455 (ReceivedByID),
  KEY FK36328477CD552686 (LoanPreparationID),
  KEY FK363284774CE675DE (DisciplineID),
  KEY FK36328477EF0E7D46 (DeaccessionPreparationID),
  KEY FK363284775327F942 (ModifiedByAgentID),
  CONSTRAINT FK363284775327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK3632847749C90455 FOREIGN KEY (ReceivedByID) REFERENCES agent (AgentID),
  CONSTRAINT FK363284774CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK363284777699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK36328477CD552686 FOREIGN KEY (LoanPreparationID) REFERENCES loanpreparation (LoanPreparationID),
  CONSTRAINT FK36328477EF0E7D46 FOREIGN KEY (DeaccessionPreparationID) REFERENCES deaccessionpreparation (DeaccessionPreparationID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table localityattachment
--

DROP TABLE IF EXISTS localityattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE localityattachment (
  LocalityAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  
  LocalityID int(11) NOT NULL,
  AttachmentID int(11) NOT NULL,
  
  PRIMARY KEY (LocalityAttachmentID),
  KEY FKB39C36C67699B003 (CreatedByAgentID),
  KEY FKB39C36C6C7E55084 (AttachmentID),
  KEY FKB39C36C6A666A5C4 (LocalityID),
  KEY FKB39C36C65327F942 (ModifiedByAgentID),
  CONSTRAINT FKB39C36C65327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKB39C36C67699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKB39C36C6A666A5C4 FOREIGN KEY (LocalityID) REFERENCES locality (LocalityID),
  CONSTRAINT FKB39C36C6C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table localitycitation
--

DROP TABLE IF EXISTS localitycitation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE localitycitation (
  LocalityCitationID int(11) NOT NULL AUTO_INCREMENT,

  

  Remarks text,
  DisciplineID int(11) NOT NULL,
  
  LocalityID int(11) NOT NULL,
  ReferenceWorkID int(11) NOT NULL,
  
  PRIMARY KEY (LocalityCitationID),
  UNIQUE KEY ReferenceWorkID (ReferenceWorkID,LocalityID),
  KEY LocCitDspMemIDX (DisciplineID),
  KEY FK9877F54A7699B003 (CreatedByAgentID),
  KEY FK9877F54A69734F30 (ReferenceWorkID),
  KEY FK9877F54A4CE675DE (DisciplineID),
  KEY FK9877F54AA666A5C4 (LocalityID),
  KEY FK9877F54A5327F942 (ModifiedByAgentID),
  CONSTRAINT FK9877F54A5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK9877F54A4CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK9877F54A69734F30 FOREIGN KEY (ReferenceWorkID) REFERENCES referencework (ReferenceWorkID),
  CONSTRAINT FK9877F54A7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK9877F54AA666A5C4 FOREIGN KEY (LocalityID) REFERENCES locality (LocalityID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table localitydetail
--

DROP TABLE IF EXISTS localitydetail;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE localitydetail (
  LocalityDetailID int(11) NOT NULL AUTO_INCREMENT,

  

  BaseMeridian varchar(50) DEFAULT NULL,
  Drainage varchar(64) DEFAULT NULL,
  EndDepth double DEFAULT NULL,
  EndDepthUnit varchar(23) DEFAULT NULL,
  EndDepthVerbatim varchar(32) DEFAULT NULL,
  GML text,
  HucCode varchar(16) DEFAULT NULL,
  Island varchar(64) DEFAULT NULL,
  IslandGroup varchar(64) DEFAULT NULL,
  MgrsZone varchar(4) DEFAULT NULL,
  NationalParkName varchar(64) DEFAULT NULL,
  Number1 double DEFAULT NULL,
  Number2 double DEFAULT NULL,
  Number3 float(20,10) DEFAULT NULL,
  Number4 float(20,10) DEFAULT NULL,
  Number5 float(20,10) DEFAULT NULL,
  PaleoLat varchar(32) DEFAULT NULL,
  PaleoLng varchar(32) DEFAULT NULL,
  RangeDesc varchar(50) DEFAULT NULL,
  RangeDirection varchar(50) DEFAULT NULL,
  Section varchar(50) DEFAULT NULL,
  SectionPart varchar(50) DEFAULT NULL,
  StartDepth double DEFAULT NULL,
  StartDepthUnit varchar(23) DEFAULT NULL,
  StartDepthVerbatim varchar(32) DEFAULT NULL,
  Text1 text,
  Text2 text,
  Text3 text,
  Text4 text,
  Text5 text,
  Township varchar(50) DEFAULT NULL,
  TownshipDirection varchar(50) DEFAULT NULL,
  UtmDatum varchar(32) DEFAULT NULL,
  UtmEasting decimal(19,2) DEFAULT NULL,
  UtmFalseEasting int(11) DEFAULT NULL,
  UtmFalseNorthing int(11) DEFAULT NULL,
  UtmNorthing decimal(19,2) DEFAULT NULL,
  UtmOrigLatitude decimal(19,2) DEFAULT NULL,
  UtmOrigLongitude decimal(19,2) DEFAULT NULL,
  UtmScale decimal(20,10) DEFAULT NULL,
  UtmZone smallint(6) DEFAULT NULL,
  WaterBody varchar(64) DEFAULT NULL,
  
  
  
  
  
  
  LocalityID int(11) DEFAULT NULL,
  
  PRIMARY KEY (LocalityDetailID),
  KEY FKBB0D3F747699B003 (CreatedByAgentID),
  KEY FKBB0D3F74A666A5C4 (LocalityID),
  KEY FKBB0D3F745327F942 (ModifiedByAgentID),
  CONSTRAINT FKBB0D3F745327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKBB0D3F747699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKBB0D3F74A666A5C4 FOREIGN KEY (LocalityID) REFERENCES locality (LocalityID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table localitynamealias
--

DROP TABLE IF EXISTS localitynamealias;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE localitynamealias (
  LocalityNameAliasID int(11) NOT NULL AUTO_INCREMENT,

  

  Name varchar(255) NOT NULL,
  Source varchar(64) NOT NULL,
  
  LocalityID int(11) NOT NULL,
  
  DisciplineID int(11) NOT NULL,
  PRIMARY KEY (LocalityNameAliasID),
  KEY LocalityNameAliasIDX (Name),
  KEY FK29EB5CA27699B003 (CreatedByAgentID),
  KEY FK29EB5CA24CE675DE (DisciplineID),
  KEY FK29EB5CA2A666A5C4 (LocalityID),
  KEY FK29EB5CA25327F942 (ModifiedByAgentID),
  CONSTRAINT FK29EB5CA25327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK29EB5CA24CE675DE FOREIGN KEY (DisciplineID) REFERENCES discipline (UserGroupScopeId),
  CONSTRAINT FK29EB5CA27699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK29EB5CA2A666A5C4 FOREIGN KEY (LocalityID) REFERENCES locality (LocalityID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table morphbankview
--

DROP TABLE IF EXISTS morphbankview;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE morphbankview (
  MorphBankViewID int(11) NOT NULL AUTO_INCREMENT,

  

  DevelopmentState varchar(128) DEFAULT NULL,
  Form varchar(128) DEFAULT NULL,
  ImagingPreparationTechnique varchar(128) DEFAULT NULL,
  ImagingTechnique varchar(128) DEFAULT NULL,
  MorphBankExternalViewID int(11) DEFAULT NULL,
  Sex varchar(32) DEFAULT NULL,
  SpecimenPart varchar(128) DEFAULT NULL,
  ViewAngle varchar(128) DEFAULT NULL,
  ViewName varchar(128) DEFAULT NULL,
  
  
  PRIMARY KEY (MorphBankViewID),
  KEY FKDED66BE97699B003 (CreatedByAgentID),
  KEY FKDED66BE95327F942 (ModifiedByAgentID),
  CONSTRAINT FKDED66BE95327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKDED66BE97699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table otheridentifier
--

DROP TABLE IF EXISTS otheridentifier;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE otheridentifier (
  OtherIdentifierID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  Identifier varchar(64) NOT NULL,
  Institution varchar(64) DEFAULT NULL,
  Remarks text,
  
  CollectionObjectID int(11) NOT NULL,
  
  PRIMARY KEY (OtherIdentifierID),
  KEY OthIdColMemIDX (CollectionMemberID),
  KEY FK2A5397B97699B003 (CreatedByAgentID),
  KEY FK2A5397B975E37458 (CollectionObjectID),
  KEY FK2A5397B95327F942 (ModifiedByAgentID),
  CONSTRAINT FK2A5397B95327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK2A5397B975E37458 FOREIGN KEY (CollectionObjectID) REFERENCES collectionobject (CollectionObjectID),
  CONSTRAINT FK2A5397B97699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table permit
--

DROP TABLE IF EXISTS permit;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE permit (
  PermitID int(11) NOT NULL AUTO_INCREMENT,

  

  EndDate date DEFAULT NULL,
  IssuedDate date DEFAULT NULL,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  PermitNumber varchar(50) NOT NULL,
  Remarks text,
  RenewalDate date DEFAULT NULL,
  StartDate date DEFAULT NULL,
  Text1 text,
  Text2 text,
  Type varchar(50) DEFAULT NULL,
  
  
  IssuedToID int(11) DEFAULT NULL,
  IssuedByID int(11) DEFAULT NULL,
  
  InstitutionID int(11) NOT NULL,
  
  PRIMARY KEY (PermitID),
  KEY PermitNumberIDX (PermitNumber),
  KEY IssuedDateIDX (IssuedDate),
  KEY FKC4E3841B7699B003 (CreatedByAgentID),
  KEY FKC4E3841B81223908 (InstitutionID),
  KEY FKC4E3841BCDCF181F (IssuedByID),
  KEY FKC4E3841BCDD72143 (IssuedToID),
  KEY FKC4E3841B5327F942 (ModifiedByAgentID),
  CONSTRAINT FKC4E3841B5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKC4E3841B7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKC4E3841B81223908 FOREIGN KEY (InstitutionID) REFERENCES institution (UserGroupScopeId),
  CONSTRAINT FKC4E3841BCDCF181F FOREIGN KEY (IssuedByID) REFERENCES agent (AgentID),
  CONSTRAINT FKC4E3841BCDD72143 FOREIGN KEY (IssuedToID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table permitattachment
--

DROP TABLE IF EXISTS permitattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE permitattachment (
  PermitAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  
  
  PermitID int(11) NOT NULL,
  AttachmentID int(11) NOT NULL,
  PRIMARY KEY (PermitAttachmentID),
  KEY FK7064B77E7699B003 (CreatedByAgentID),
  KEY FK7064B77EAD1F31F4 (PermitID),
  KEY FK7064B77EC7E55084 (AttachmentID),
  KEY FK7064B77E5327F942 (ModifiedByAgentID),
  CONSTRAINT FK7064B77E5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK7064B77E7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK7064B77EAD1F31F4 FOREIGN KEY (PermitID) REFERENCES permit (PermitID),
  CONSTRAINT FK7064B77EC7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table preparationattachment
--

DROP TABLE IF EXISTS preparationattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE preparationattachment (
  PreparationAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  Ordinal int(11) NOT NULL,
  Remarks text,
  
  AttachmentID int(11) NOT NULL,
  PreparationID int(11) NOT NULL,
  
  PRIMARY KEY (PreparationAttachmentID),
  KEY PrepAttColMemIDX (CollectionMemberID),
  KEY FKE3FD6EFA7699B003 (CreatedByAgentID),
  KEY FKE3FD6EFA18627F06 (PreparationID),
  KEY FKE3FD6EFAC7E55084 (AttachmentID),
  KEY FKE3FD6EFA5327F942 (ModifiedByAgentID),
  CONSTRAINT FKE3FD6EFA5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKE3FD6EFA18627F06 FOREIGN KEY (PreparationID) REFERENCES preparation (PreparationID),
  CONSTRAINT FKE3FD6EFA7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKE3FD6EFAC7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table preparationattr
--

DROP TABLE IF EXISTS preparationattr;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE preparationattr (
  AttrID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  DoubleValue double DEFAULT NULL,
  StrValue varchar(255) DEFAULT NULL,
  PreparationId int(11) NOT NULL,
  AttributeDefID int(11) NOT NULL,
  
  
  PRIMARY KEY (AttrID),
  KEY PrepAttrColMemIDX (CollectionMemberID),
  KEY FK4592DD087699B003 (CreatedByAgentID),
  KEY FK4592DD08E84BA7B0 (AttributeDefID),
  KEY FK4592DD0818627F06 (PreparationId),
  KEY FK4592DD085327F942 (ModifiedByAgentID),
  CONSTRAINT FK4592DD085327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK4592DD0818627F06 FOREIGN KEY (PreparationId) REFERENCES preparation (PreparationID),
  CONSTRAINT FK4592DD087699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK4592DD08E84BA7B0 FOREIGN KEY (AttributeDefID) REFERENCES attributedef (AttributeDefID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table preparationattribute
--

DROP TABLE IF EXISTS preparationattribute;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE preparationattribute (
  PreparationAttributeID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  AttrDate datetime DEFAULT NULL,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  Number3 float(20,10) DEFAULT NULL,
  Number4 int(11) DEFAULT NULL,
  Number5 int(11) DEFAULT NULL,
  Number6 int(11) DEFAULT NULL,
  Number7 int(11) DEFAULT NULL,
  Number8 int(11) DEFAULT NULL,
  Number9 smallint(6) DEFAULT NULL,
  Remarks text,
  Text1 text,
  Text10 text,
  Text11 varchar(50) DEFAULT NULL,
  Text12 varchar(50) DEFAULT NULL,
  Text13 varchar(50) DEFAULT NULL,
  Text14 varchar(50) DEFAULT NULL,
  Text15 varchar(50) DEFAULT NULL,
  Text16 varchar(50) DEFAULT NULL,
  Text17 varchar(50) DEFAULT NULL,
  Text18 varchar(50) DEFAULT NULL,
  Text19 varchar(50) DEFAULT NULL,
  Text2 text,
  Text20 varchar(50) DEFAULT NULL,
  Text21 varchar(50) DEFAULT NULL,
  Text22 varchar(50) DEFAULT NULL,
  Text23 varchar(50) DEFAULT NULL,
  Text24 varchar(50) DEFAULT NULL,
  Text25 varchar(50) DEFAULT NULL,
  Text26 varchar(50) DEFAULT NULL,
  Text3 varchar(50) DEFAULT NULL,
  Text4 varchar(50) DEFAULT NULL,
  Text5 varchar(50) DEFAULT NULL,
  Text6 varchar(50) DEFAULT NULL,
  Text7 varchar(50) DEFAULT NULL,
  Text8 varchar(50) DEFAULT NULL,
  Text9 varchar(50) DEFAULT NULL,
  
  
  
  
  
  
  PRIMARY KEY (PreparationAttributeID),
  KEY PrepAttrsColMemIDX (CollectionMemberID),
  KEY FK984BFDE57699B003 (CreatedByAgentID),
  KEY FK984BFDE55327F942 (ModifiedByAgentID),
  CONSTRAINT FK984BFDE55327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK984BFDE57699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table preptype
--

DROP TABLE IF EXISTS preptype;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE preptype (
  PrepTypeID int(11) NOT NULL AUTO_INCREMENT,

  

  IsLoanable bit(1) NOT NULL,
  Name varchar(64) NOT NULL,
  
  CollectionID int(11) NOT NULL,
  
  PRIMARY KEY (PrepTypeID),
  KEY FKB3C452E77699B003 (CreatedByAgentID),
  KEY FKB3C452E78C2288BA (CollectionID),
  KEY FKB3C452E75327F942 (ModifiedByAgentID),
  CONSTRAINT FKB3C452E75327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKB3C452E77699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKB3C452E78C2288BA FOREIGN KEY (CollectionID) REFERENCES collection (UserGroupScopeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table project
--

DROP TABLE IF EXISTS project;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE project (
  ProjectID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  EndDate date DEFAULT NULL,
  GrantAgency varchar(64) DEFAULT NULL,
  GrantNumber varchar(64) DEFAULT NULL,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  ProjectDescription varchar(255) DEFAULT NULL,
  ProjectName varchar(128) NOT NULL,
  ProjectNumber varchar(64) DEFAULT NULL,
  Remarks text,
  StartDate date DEFAULT NULL,
  Text1 text,
  Text2 text,
  URL varchar(1024) DEFAULT NULL,
  
  
  
  ProjectAgentID int(11) DEFAULT NULL,
  
  PRIMARY KEY (ProjectID),
  KEY ProjectNumberIDX (ProjectNumber),
  KEY ProjectNameIDX (ProjectName),
  KEY FKED904B197699B003 (CreatedByAgentID),
  KEY FKED904B195DDECE9 (ProjectAgentID),
  KEY FKED904B195327F942 (ModifiedByAgentID),
  CONSTRAINT FKED904B195327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKED904B195DDECE9 FOREIGN KEY (ProjectAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKED904B197699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table project_colobj
--

DROP TABLE IF EXISTS project_colobj;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE project_colobj (
  ProjectID int(11) NOT NULL,
  CollectionObjectID int(11) NOT NULL,
  PRIMARY KEY (ProjectID,CollectionObjectID),
  KEY FK1E416F5D75E37458 (CollectionObjectID),
  KEY FK1E416F5DAF28760A (ProjectID),
  CONSTRAINT FK1E416F5DAF28760A FOREIGN KEY (ProjectID) REFERENCES project (ProjectID),
  CONSTRAINT FK1E416F5D75E37458 FOREIGN KEY (CollectionObjectID) REFERENCES collectionobject (CollectionObjectID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table recordset
--

DROP TABLE IF EXISTS recordset;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE recordset (
  RecordSetID int(11) NOT NULL AUTO_INCREMENT,

  

  CollectionMemberID int(11) NOT NULL,
  AllPermissionLevel int(11) DEFAULT NULL,
  TableID int(11) NOT NULL,
  GroupPermissionLevel int(11) DEFAULT NULL,
  Name varchar(64) NOT NULL,
  OwnerPermissionLevel int(11) DEFAULT NULL,
  Remarks text,
  Type tinyint(4) NOT NULL,
  
  
  SpPrincipalID int(11) DEFAULT NULL,
  InfoRequestID int(11) DEFAULT NULL,
  SpecifyUserID int(11) NOT NULL,
  PRIMARY KEY (RecordSetID),
  KEY RecordSetNameIDX (Name),
  KEY FK3B38A2717699B003 (CreatedByAgentID),
  KEY FK3B38A27110D22B7A (InfoRequestID),
  KEY FK3B38A27199A7381A (SpPrincipalID),
  KEY FK3B38A2714BDD9E10 (SpecifyUserID),
  KEY FK3B38A2715327F942 (ModifiedByAgentID),
  CONSTRAINT FK3B38A2715327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK3B38A27110D22B7A FOREIGN KEY (InfoRequestID) REFERENCES inforequest (InfoRequestID),
  CONSTRAINT FK3B38A2714BDD9E10 FOREIGN KEY (SpecifyUserID) REFERENCES specifyuser (SpecifyUserID),
  CONSTRAINT FK3B38A2717699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK3B38A27199A7381A FOREIGN KEY (SpPrincipalID) REFERENCES spprincipal (SpPrincipalID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table recordsetitem
--

DROP TABLE IF EXISTS recordsetitem;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE recordsetitem (
  RecordSetItemID int(11) NOT NULL AUTO_INCREMENT,
  OrderNumber int(11) DEFAULT NULL,
  RecordId int(11) NOT NULL,
  RecordSetID int(11) NOT NULL,
  PRIMARY KEY (RecordSetItemID),
  KEY FKD0817D047F06EB5A (RecordSetID),
  CONSTRAINT FKD0817D047F06EB5A FOREIGN KEY (RecordSetID) REFERENCES recordset (RecordSetID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table referencework
--

DROP TABLE IF EXISTS referencework;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE referencework (
  ReferenceWorkID int(11) NOT NULL AUTO_INCREMENT,

  

  GUID varchar(128) DEFAULT NULL,
  IsPublished bit(1) DEFAULT NULL,
  ISBN varchar(16) DEFAULT NULL,
  LibraryNumber varchar(50) DEFAULT NULL,
  Number1 float(20,10) DEFAULT NULL,
  Number2 float(20,10) DEFAULT NULL,
  Pages varchar(50) DEFAULT NULL,
  PlaceOfPublication varchar(50) DEFAULT NULL,
  Publisher varchar(250) DEFAULT NULL,
  ReferenceWorkType tinyint(4) NOT NULL,
  Remarks text,
  Text1 text,
  Text2 text,
  Title varchar(255) DEFAULT NULL,
  URL varchar(1024) DEFAULT NULL,
  Volume varchar(25) DEFAULT NULL,
  WorkDate varchar(25) DEFAULT NULL,
  
  
  JournalID int(11) DEFAULT NULL,
  
  InstitutionID int(11) NOT NULL,
  ContainedRFParentID int(11) DEFAULT NULL,
  
  PRIMARY KEY (ReferenceWorkID),
  KEY RefWrkPublisherIDX (Publisher),
  KEY RefWrkGuidIDX (GUID),
  KEY ISBNIDX (ISBN),
  KEY RefWrkTitleIDX (Title),
  KEY FK5F7C68DC7699B003 (CreatedByAgentID),
  KEY FK5F7C68DC81223908 (InstitutionID),
  KEY FK5F7C68DC748AEC6 (JournalID),
  KEY FK5F7C68DC1B806665 (ContainedRFParentID),
  KEY FK5F7C68DC5327F942 (ModifiedByAgentID),
  CONSTRAINT FK5F7C68DC5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK5F7C68DC1B806665 FOREIGN KEY (ContainedRFParentID) REFERENCES referencework (ReferenceWorkID),
  CONSTRAINT FK5F7C68DC748AEC6 FOREIGN KEY (JournalID) REFERENCES journal (JournalID),
  CONSTRAINT FK5F7C68DC7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK5F7C68DC81223908 FOREIGN KEY (InstitutionID) REFERENCES institution (UserGroupScopeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table referenceworkattachment
--

DROP TABLE IF EXISTS referenceworkattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE referenceworkattachment (
  ReferenceWorkAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  AttachmentID int(11) NOT NULL,
  
  
  ReferenceWorkID int(11) NOT NULL,
  PRIMARY KEY (ReferenceWorkAttachmentID),
  KEY FK9C9B5EFF7699B003 (CreatedByAgentID),
  KEY FK9C9B5EFF69734F30 (ReferenceWorkID),
  KEY FK9C9B5EFFC7E55084 (AttachmentID),
  KEY FK9C9B5EFF5327F942 (ModifiedByAgentID),
  CONSTRAINT FK9C9B5EFF5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK9C9B5EFF69734F30 FOREIGN KEY (ReferenceWorkID) REFERENCES referencework (ReferenceWorkID),
  CONSTRAINT FK9C9B5EFF7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK9C9B5EFFC7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table repositoryagreementattachment
--

DROP TABLE IF EXISTS repositoryagreementattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE repositoryagreementattachment (
  RepositoryAgreementAttachmentID int(11) NOT NULL AUTO_INCREMENT,
  Ordinal int(11) DEFAULT NULL,
  Remarks text,
  RepositoryAgreementID int(11) NOT NULL,
  
  
  AttachmentID int(11) NOT NULL,
  PRIMARY KEY (RepositoryAgreementAttachmentID),
  KEY FK93663237699B003 (CreatedByAgentID),
  KEY FK93663233EBC6278 (RepositoryAgreementID),
  KEY FK9366323C7E55084 (AttachmentID),
  KEY FK93663235327F942 (ModifiedByAgentID),
  CONSTRAINT FK93663235327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK93663233EBC6278 FOREIGN KEY (RepositoryAgreementID) REFERENCES repositoryagreement (RepositoryAgreementID),
  CONSTRAINT FK93663237699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK9366323C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table storageattachment
--

DROP TABLE IF EXISTS storageattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE storageattachment (
  StorageAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  

  Ordinal int(11) NOT NULL,
  Remarks text,
  AttachmentID int(11) NOT NULL,
  
  
  StorageID int(11) NOT NULL,
  PRIMARY KEY (StorageAttachmentID),
  KEY FKBE9EFDDE7699B003 (CreatedByAgentID),
  KEY FKBE9EFDDEC7E55084 (AttachmentID),
  KEY FKBE9EFDDE5327F942 (ModifiedByAgentID),
  KEY FKBE9EFDDEEB48144E (StorageID),
  CONSTRAINT FKBE9EFDDEEB48144E FOREIGN KEY (StorageID) REFERENCES storage (StorageID),
  CONSTRAINT FKBE9EFDDE5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKBE9EFDDE7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKBE9EFDDEC7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table taxonattachment
--

DROP TABLE IF EXISTS taxonattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE taxonattachment (
  TaxonAttachmentID int(11) NOT NULL AUTO_INCREMENT,

  Ordinal int(11) NOT NULL,
  Remarks text,
  
  AttachmentID int(11) NOT NULL,
  TaxonID int(11) NOT NULL,
  
  PRIMARY KEY (TaxonAttachmentID),
  KEY FKF523736D7699B003 (CreatedByAgentID),
  KEY FKF523736DC7E55084 (AttachmentID),
  KEY FKF523736D1D39F06C (TaxonID),
  KEY FKF523736D5327F942 (ModifiedByAgentID),
  CONSTRAINT FKF523736D5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKF523736D1D39F06C FOREIGN KEY (TaxonID) REFERENCES taxon (TaxonID),
  CONSTRAINT FKF523736D7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKF523736DC7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table taxoncitation
--

DROP TABLE IF EXISTS taxoncitation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE taxoncitation (
  TaxonCitationID int(11) NOT NULL AUTO_INCREMENT,

  Remarks text,
  
  ReferenceWorkID int(11) NOT NULL,
  TaxonID int(11) NOT NULL,
  PRIMARY KEY (TaxonCitationID),
  KEY FK14242FB17699B003 (CreatedByAgentID),
  KEY FK14242FB169734F30 (ReferenceWorkID),
  KEY FK14242FB11D39F06C (TaxonID),
  KEY FK14242FB15327F942 (ModifiedByAgentID),
  CONSTRAINT FK14242FB15327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK14242FB11D39F06C FOREIGN KEY (TaxonID) REFERENCES taxon (TaxonID),
  CONSTRAINT FK14242FB169734F30 FOREIGN KEY (ReferenceWorkID) REFERENCES referencework (ReferenceWorkID),
  CONSTRAINT FK14242FB17699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table taxontreedef
--

DROP TABLE IF EXISTS taxontreedef;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE taxontreedef (
  TaxonTreeDefID int(11) NOT NULL AUTO_INCREMENT,
  FullNameDirection int(11) DEFAULT NULL,
  Name varchar(64) NOT NULL,
  Remarks varchar(255) DEFAULT NULL,
  
  PRIMARY KEY (TaxonTreeDefID),
  KEY FK169B1D9D7699B003 (CreatedByAgentID),
  KEY FK169B1D9D5327F942 (ModifiedByAgentID),
  CONSTRAINT FK169B1D9D5327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK169B1D9D7699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table taxontreedefitem
--

DROP TABLE IF EXISTS taxontreedefitem;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE taxontreedefitem (
  TaxonTreeDefItemID int(11) NOT NULL AUTO_INCREMENT,
  FormatToken varchar(32) DEFAULT NULL,
  FullNameSeparator varchar(32) DEFAULT NULL,
  IsEnforced bit(1) DEFAULT NULL,
  IsInFullName bit(1) DEFAULT NULL,
  Name varchar(64) NOT NULL,
  RankID int(11) NOT NULL,
  Remarks text,
  TextAfter varchar(64) DEFAULT NULL,
  TextBefore varchar(64) DEFAULT NULL,
  Title varchar(64) DEFAULT NULL,
  
  TaxonTreeDefID int(11) NOT NULL,
  ParentItemID int(11) DEFAULT NULL,
  
  PRIMARY KEY (TaxonTreeDefItemID),
  KEY FKF29A82307699B003 (CreatedByAgentID),
  KEY FKF29A8230EFA9D5F8 (TaxonTreeDefID),
  KEY FKF29A82305327F942 (ModifiedByAgentID),
  KEY FKF29A82306A76BE4B (ParentItemID),
  CONSTRAINT FKF29A82306A76BE4B FOREIGN KEY (ParentItemID) REFERENCES taxontreedefitem (TaxonTreeDefItemID),
  CONSTRAINT FKF29A82305327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKF29A82307699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FKF29A8230EFA9D5F8 FOREIGN KEY (TaxonTreeDefID) REFERENCES taxontreedef (TaxonTreeDefID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table treatmentevent
--

DROP TABLE IF EXISTS treatmentevent;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE treatmentevent (
  TreatmentEventID int(11) NOT NULL AUTO_INCREMENT,
  DateBoxed date DEFAULT NULL,
  DateCleaned date DEFAULT NULL,
  DateCompleted date DEFAULT NULL,
  DateReceived date DEFAULT NULL,
  DateToIsolation date DEFAULT NULL,
  DateTreatmentEnded date DEFAULT NULL,
  DateTreatmentStarted date DEFAULT NULL,
  FieldNumber varchar(50) DEFAULT NULL,
  Storage varchar(64) DEFAULT NULL,
  Remarks text,
  TreatmentNumber varchar(32) DEFAULT NULL,
  Type varchar(32) DEFAULT NULL,
  
  CollectionObjectID int(11) DEFAULT NULL,
  
  AuthorizedByID int(11) DEFAULT NULL,
  
  AccessionID int(11) DEFAULT NULL,
  DivisionID int(11) DEFAULT NULL,
  PerformedByID int(11) DEFAULT NULL,
  PRIMARY KEY (TreatmentEventID),
  KEY TETreatmentNumberIDX (TreatmentNumber),
  KEY TEFieldNumberIDX (FieldNumber),
  KEY TEDateReceivedIDX (DateReceived),
  KEY TEDateTreatmentStartedIDX (DateTreatmentStarted),
  KEY FK577D85227699B003 (CreatedByAgentID),
  KEY FK577D852275E37458 (CollectionObjectID),
  KEY FK577D8522410EB2B4 (PerformedByID),
  KEY FK577D852297C961D8 (DivisionID),
  KEY FK577D85227D49A30F (AuthorizedByID),
  KEY FK577D85223925EE20 (AccessionID),
  KEY FK577D85225327F942 (ModifiedByAgentID),
  CONSTRAINT FK577D85225327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK577D85223925EE20 FOREIGN KEY (AccessionID) REFERENCES accession (AccessionID),
  CONSTRAINT FK577D8522410EB2B4 FOREIGN KEY (PerformedByID) REFERENCES agent (AgentID),
  CONSTRAINT FK577D852275E37458 FOREIGN KEY (CollectionObjectID) REFERENCES collectionobject (CollectionObjectID),
  CONSTRAINT FK577D85227699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK577D85227D49A30F FOREIGN KEY (AuthorizedByID) REFERENCES agent (AgentID),
  CONSTRAINT FK577D852297C961D8 FOREIGN KEY (DivisionID) REFERENCES division (UserGroupScopeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table treatmenteventattachment
--

DROP TABLE IF EXISTS treatmenteventattachment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE treatmenteventattachment (
  TreatmentEventAttachmentID int(11) NOT NULL AUTO_INCREMENT,
  Ordinal int(11) NOT NULL,
  Remarks text,
  
  TreatmentEventID int(11) NOT NULL,
  AttachmentID int(11) NOT NULL,
  PRIMARY KEY (TreatmentEventAttachmentID),
  KEY FK1725BC57699B003 (CreatedByAgentID),
  KEY FK1725BC5C7E55084 (AttachmentID),
  KEY FK1725BC52BE40B22 (TreatmentEventID),
  KEY FK1725BC55327F942 (ModifiedByAgentID),
  CONSTRAINT FK1725BC55327F942 FOREIGN KEY (ModifiedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK1725BC52BE40B22 FOREIGN KEY (TreatmentEventID) REFERENCES treatmentevent (TreatmentEventID),
  CONSTRAINT FK1725BC57699B003 FOREIGN KEY (CreatedByAgentID) REFERENCES agent (AgentID),
  CONSTRAINT FK1725BC5C7E55084 FOREIGN KEY (AttachmentID) REFERENCES attachment (AttachmentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
