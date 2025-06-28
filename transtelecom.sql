create table clients
(
    client_id         int auto_increment
        primary key,
    full_name         varchar(150)                    null,
    company_name      varchar(150)                    null,
    client_type       enum ('Individual', 'Business') null,
    phone             varchar(20)                     null,
    email             varchar(100)                    null,
    registration_date date                            null,
    region            varchar(100)                    null
);

create table employees
(
    employee_id int auto_increment
        primary key,
    full_name   varchar(100) null,
    position    varchar(50)  null,
    department  varchar(50)  null,
    hire_date   date         null,
    email       varchar(100) null,
    phone       varchar(20)  null
);

create table regions
(
    region_id   int auto_increment
        primary key,
    region_name varchar(100) null,
    city        varchar(100) null,
    address     varchar(200) null
);

create table services
(
    service_id   int auto_increment
        primary key,
    service_name varchar(100)                                                             null,
    category     enum ('Internet', 'Cloud', 'Hosting', 'Telephony', 'VPN', 'Data Center') null,
    description  text                                                                     null,
    monthly_cost decimal(10, 2)                                                           null,
    is_active    tinyint(1) default 1                                                     null
);

create table contracts
(
    contract_id   int auto_increment
        primary key,
    client_id     int                                     null,
    service_id    int                                     null,
    contract_date date                                    null,
    status        enum ('Active', 'Paused', 'Terminated') null,
    auto_renew    tinyint(1)                              null,
    constraint contracts_ibfk_1
        foreign key (client_id) references clients (client_id),
    constraint contracts_ibfk_2
        foreign key (service_id) references services (service_id)
);

create table bills
(
    bill_id     int auto_increment
        primary key,
    contract_id int                  null,
    bill_date   date                 null,
    amount_due  decimal(10, 2)       null,
    due_date    date                 null,
    is_paid     tinyint(1) default 0 null,
    constraint bills_ibfk_1
        foreign key (contract_id) references contracts (contract_id)
);

create index contract_id
    on bills (contract_id);

create index client_id
    on contracts (client_id);

create index service_id
    on contracts (service_id);

create table support_requests
(
    request_id  int auto_increment
        primary key,
    client_id   int                                                null,
    subject     varchar(255)                                       null,
    description text                                               null,
    status      enum ('Open', 'In Progress', 'Resolved', 'Closed') null,
    priority    enum ('Low', 'Medium', 'High', 'Critical')         null,
    created_at  datetime                                           null,
    resolved_at datetime                                           null,
    constraint support_requests_ibfk_1
        foreign key (client_id) references clients (client_id)
);

create table assignments
(
    assignment_id int auto_increment
        primary key,
    request_id    int      null,
    employee_id   int      null,
    assigned_at   datetime null,
    constraint assignments_ibfk_1
        foreign key (request_id) references support_requests (request_id)
);

create index employee_id
    on assignments (employee_id);

create index request_id
    on assignments (request_id);

create index client_id
    on support_requests (client_id);


