/*
Created Database ChocolateSale and the layer within the database :"bronze, "silver", and "gold"
Warning :
Running this script will drop the entire 'ChocolateSales' databaseif it exists.
All data in the database will be permanantly deleted. Processd with cautionand ensure you have proper backup before running this scripts
*/

USE master;
IF EXISTS (SELECT 1 from sys.databases where name = "ChocolateSales)
  BEGIN
  ALTER DATABASE ChocolateSales SET SINGLE_USER WITH ROLLBACK IMMEDIATE:
  DROP DATABASE ChocolateSales;

  END;
  GO
  -- CREATE DATABASE "ChocolateSales"
CREATE DATABASE ChocolateSales;

USE ChocolateSales;

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
