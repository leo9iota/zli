DROP DATABASE IF EXISTS pizza_express_solution;
CREATE DATABASE pizza_express_solution;
USE pizza_express_solution;

CREATE TABLE zip (
    id   INT UNSIGNED         NOT NULL AUTO_INCREMENT,
    zip  SMALLINT(4) UNSIGNED NOT NULL,
    city VARCHAR(255)         NOT NULL,

    PRIMARY KEY (id),
    UNIQUE (zip, city)
);

CREATE TABLE customer (
    id        INT UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_zip_id INT UNSIGNED NOT NULL,
    firstname VARCHAR(255) NOT NULL,
    lastname  VARCHAR(255) NOT NULL,
    address   VARCHAR(255) NOT NULL,
    email     VARCHAR(384) NOT NULL UNIQUE,
    password  VARCHAR(255) NOT NULL,
    phone     VARCHAR(255),

    PRIMARY KEY (id),
    FOREIGN KEY (fk_zip_id) REFERENCES zip (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE category (
    id       INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE product (
    id             INT UNSIGNED  NOT NULL AUTO_INCREMENT,
    fk_category_id INT UNSIGNED  NOT NULL,
    name           VARCHAR(255)  NOT NULL,
    description    VARCHAR(255)  NOT NULL,
    price          DECIMAL(6, 2) NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (fk_category_id) REFERENCES category (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE order_entry (
    id             INT UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_customer_id INT UNSIGNED NOT NULL,
    ordered_at     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    delivered_at   DATETIME     NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (fk_customer_id) REFERENCES customer (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE product_order_entry (
    id                INT UNSIGNED  NOT NULL AUTO_INCREMENT,
    fk_product_id     INT UNSIGNED  NOT NULL,
    fk_order_entry_id INT UNSIGNED  NOT NULL,
    amount            INT UNSIGNED  NOT NULL DEFAULT 1,
    price             DECIMAL(6, 2) NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (fk_product_id) REFERENCES product (id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (fk_order_entry_id) REFERENCES order_entry (id) ON UPDATE CASCADE ON DELETE CASCADE
);
