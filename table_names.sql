USE TSQLV4;

SELECT TABLE_NAME -- Other columns: TABLE_CATALOG, TABLE_SCHEMA, TABLE_TYPE.
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'Sales';
