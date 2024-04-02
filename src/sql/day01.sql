--ex2_2
CREATE TABLE ex2_2(
                      COLUMN1 VARCHAR2(3),
                      COLUMN2 VARCHAR2(3 byte),
                      COLUMN3 VARCHAR2(3 char)
);

INSERT INTO ex2_2 (column1, column2, column3) VALUES ('abc','abc','abc');
SELECT * FROM ex2_2;

SELECT column1, LENGTH(column1) AS len1,
       column2, LENGTH(column2) AS len2,
       column3, LENGTH(column3) AS len3
FROM ex2_2;

INSERT INTO ex2_2 (column3) VALUES ('홍길동');

SELECT column3, LENGTH(column3) AS len3, LENGTHB(column3) AS bytelen
FROM ex2_2;

--ex2_3
CREATE TABLE ex2_3(
                      COL_INT INTEGER,
                      COL_DEC DECIMAL,
                      COL_NUM NUMBER
);

SELECT column_id, column_name, data_type, data_length
FROM USER_TAB_COLS
WHERE table_name = 'EX2_3'
ORDER BY column_id;


--ex2_5
CREATE TABLE ex2_5(
                      COL_DATE DATE,
                      COL_TIMESTAMP TIMESTAMP
);

INSERT INTO ex2_5 VALUES (SYSDATE, SYSTIMESTAMP);

SELECT *
FROM ex2_5;


--ex_6
CREATE TABLE ex2_6(
                      COL_NULL VARCHAR2(10),
                      COL_NOT_NULL VARCHAR2(10) NOT NULL
);

INSERT INTO ex2_6 VALUES ('AA', '');

INSERT INTO ex2_6 VALUES ('AA', 'BB');

SELECT constraint_name, constraint_type, table_name, search_condition
FROM USER_CONSTRAINTS
WHERE table_name = 'EX2_6';

--ex_7
CREATE TABLE ex2_7(
    COL_UNIQUE_NULL VARCHAR2(10) UNIQUE,
    COL_UNIQUE_NNULL VARCHAR2(10) UNIQUE NOT NULL,
    COL_UNIQUE VARCHAR2(10),
    CONSTRAINTS unique_nm1 UNIQUE (COL_UNIQUE)
);

SELECT constraint_name, constraint_type, table_name, search_condition
FROM USER_CONSTRAINTS
WHERE table_name = 'EX2_7';

INSERT INTO ex2_7 VALUES ('AA','AA','AA');

INSERT INTO ex2_7 VALUES ('AA','AA','AA');

INSERT INTO ex2_7 VALUES ('','BB','BB');

INSERT INTO ex2_7 VALUES ('','CC','CC'); 