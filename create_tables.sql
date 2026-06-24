-- CUSTOMER
CREATE TABLE customer (
    customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address TEXT NOT NULL
);

-- RESTAURANT
CREATE TABLE restaurant (
    restaurant_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    phone VARCHAR(20) NOT NULL
);

-- DELIVERY AGENTS
CREATE TABLE delivery_agents (
    agent_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    vehicle_type VARCHAR(50) NOT NULL
);

-- MENU ITEMS
CREATE TABLE menu_items (
    item_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0),

    CONSTRAINT fk_menu_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES restaurant(restaurant_id)
        ON DELETE CASCADE
);

-- ORDERS
CREATE TABLE orders (
    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10,2) CHECK (total_amount >= 0),

    status VARCHAR(20)
    CHECK (
        status IN (
            'Pending',
            'Preparing',
            'Out for Delivery',
            'Delivered',
            'Cancelled'
        )
    ),

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
);

-- ORDER DETAILS
CREATE TABLE order_details (
    detail_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,

    quantity INT NOT NULL
    CHECK (quantity > 0),

    subtotal NUMERIC(10,2)
    CHECK (subtotal >= 0),

    CONSTRAINT fk_detail_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_detail_item
        FOREIGN KEY (item_id)
        REFERENCES menu_items(item_id)
);

