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

-- PAYMENTS
-- One payment per order (1:1)
CREATE TABLE payments (
    payment_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    order_id INT UNIQUE NOT NULL,

    payment_method VARCHAR(20)
    CHECK (
        payment_method IN (
            'Cash',
            'Credit Card',
            'Debit Card',
            'Easypaisa',
            'JazzCash'
        )
    ),

    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    amount NUMERIC(10,2)
    CHECK (amount >= 0),

    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE
);

-- DELIVERIES
-- One delivery per order (1:1)
CREATE TABLE deliveries (
    delivery_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    order_id INT UNIQUE NOT NULL,
    agent_id INT NOT NULL,

    delivery_status VARCHAR(20)
    CHECK (
        delivery_status IN (
            'Assigned',
            'Picked Up',
            'Out for Delivery',
            'Delivered'
        )
    ),

    delivery_time TIMESTAMP,

    CONSTRAINT fk_delivery_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_delivery_agent
        FOREIGN KEY (agent_id)
        REFERENCES delivery_agents(agent_id)
);

CREATE TABLE reviews (
    review_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    customer_id INT NOT NULL,

    restaurant_id INT NULL,
    agent_id INT NULL,
    order_id INT NULL,

    rating INT CHECK (rating BETWEEN 1 AND 5),

    comment TEXT,

    CONSTRAINT fk_reviews_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    CONSTRAINT fk_reviews_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES restaurant(restaurant_id),

    CONSTRAINT fk_reviews_agent
        FOREIGN KEY (agent_id)
        REFERENCES delivery_agents(agent_id),

    CONSTRAINT fk_reviews_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    -- ensures review is for ONLY ONE target
    CONSTRAINT chk_review_target
    CHECK (
        (restaurant_id IS NOT NULL)::int +
        (agent_id IS NOT NULL)::int +
        (order_id IS NOT NULL)::int = 1
    )
);

