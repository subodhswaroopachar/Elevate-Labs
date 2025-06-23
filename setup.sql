-- Create the database
CREATE DATABASE IF NOT EXISTS banking_system;
USE banking_system;

-- Create customer/account table
CREATE TABLE t1 (
    acno VARCHAR(20),
    ifsc VARCHAR(20),
    name VARCHAR(100),
    type VARCHAR(20),
    PRIMARY KEY (acno, ifsc)
);

-- Create transaction table with txn_date
CREATE TABLE t2 (
    tid INT AUTO_INCREMENT PRIMARY KEY,
    source_ac VARCHAR(20),
    sifsc VARCHAR(20),
    destination_ac VARCHAR(20),
    difsc VARCHAR(20),
    amount DECIMAL(10, 2),
    remark VARCHAR(255),
    txn_date DATE,
    FOREIGN KEY (source_ac, sifsc) REFERENCES t1(acno, ifsc),
    FOREIGN KEY (destination_ac, difsc) REFERENCES t1(acno, ifsc)
);

-- Insert 100 random records into t2 with random dates
DELIMITER //

CREATE PROCEDURE insert_100_t2()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE src_ac VARCHAR(20);
    DECLARE src_ifsc VARCHAR(20);
    DECLARE dest_ac VARCHAR(20);
    DECLARE dest_ifsc VARCHAR(20);
    DECLARE random_date DATE;

    WHILE i <= 100 DO
        -- Pick random source
        SELECT acno, ifsc INTO src_ac, src_ifsc
        FROM t1
        ORDER BY RAND()
        LIMIT 1;

        -- Pick random destination (not same)
        SELECT acno, ifsc INTO dest_ac, dest_ifsc
        FROM t1
        WHERE acno != src_ac
        ORDER BY RAND()
        LIMIT 1;

        -- Generate a random date between 2023-01-01 and 2025-12-31
        SET random_date = DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 1095) DAY);

        -- Insert
        INSERT INTO t2 (source_ac, sifsc, destination_ac, difsc, amount, remark, txn_date)
        VALUES (
            src_ac,
            src_ifsc,
            dest_ac,
            dest_ifsc,
            ROUND(RAND() * 10000, 2),
            CONCAT('Auto Txn ', i),
            random_date
        );

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

mysql -u root -p < setup.sql
USE banking_system;
CALL insert_100_t2();

--just open  mysql and run the code

-- ✅ Create the user
CREATE USER 'subodh'@'localhost' IDENTIFIED BY 'yourpassword';

-- ✅ Grant full access to your actual database
GRANT ALL PRIVILEGES ON banking_system.* TO 'subodh'@'localhost';

-- ✅ Apply the changes
FLUSH PRIVILEGES;

-- ✅ Exit MySQL
EXIT;
