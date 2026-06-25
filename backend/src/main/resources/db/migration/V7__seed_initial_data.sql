INSERT INTO app_users (role, first_name, last_name, email, phone, password_hash, active)
VALUES
    ('ADMIN', 'Admin', 'User', 'admin@autodelovi.test', '+381600000001', '$2a$10$9HvN28mpBVhkhkJyv8.Ux.1lTNUjvEtFHKkcwLnLYaR2umH6o7nPG', TRUE),
    ('EMPLOYEE', 'Employee', 'User', 'employee@autodelovi.test', '+381600000002', '$2a$10$9HvN28mpBVhkhkJyv8.Ux.1lTNUjvEtFHKkcwLnLYaR2umH6o7nPG', TRUE),
    ('CLIENT', 'Client', 'User', 'client@autodelovi.test', '+381600000003', '$2a$10$9HvN28mpBVhkhkJyv8.Ux.1lTNUjvEtFHKkcwLnLYaR2umH6o7nPG', TRUE);

INSERT INTO part_categories (name, slug, description)
VALUES
    ('Kocioni sistem', 'kocioni-sistem', 'Delovi za kocioni sistem vozila.'),
    ('Filteri', 'filteri', 'Filteri ulja, vazduha, goriva i kabine.'),
    ('Elektrika', 'elektrika', 'Akumulatori, sijalice i ostali elektricni delovi.'),
    ('Menjac', 'menjac', 'Delovi menjaca i kvacila.');

INSERT INTO vehicle_makes (name)
VALUES
    ('Volkswagen'),
    ('Opel'),
    ('Fiat'),
    ('Univerzalno');

INSERT INTO vehicle_models (make_id, name, year_from, year_to)
VALUES
    ((SELECT id FROM vehicle_makes WHERE name = 'Volkswagen'), 'Golf 7', 2012, 2020),
    ((SELECT id FROM vehicle_makes WHERE name = 'Opel'), 'Astra J', 2009, 2015),
    ((SELECT id FROM vehicle_makes WHERE name = 'Fiat'), 'Punto', 1999, 2018),
    ((SELECT id FROM vehicle_makes WHERE name = 'Univerzalno'), 'Univerzalni deo', NULL, NULL);

INSERT INTO parts (
    category_id,
    vehicle_make_id,
    vehicle_model_id,
    sku,
    name,
    description,
    manufacturer,
    price,
    stock_quantity,
    image_url,
    active
)
VALUES
    (
        (SELECT id FROM part_categories WHERE slug = 'kocioni-sistem'),
        (SELECT id FROM vehicle_makes WHERE name = 'Volkswagen'),
        (SELECT id FROM vehicle_models WHERE name = 'Golf 7'),
        'BRK-GOLF7-FRONT',
        'Prednje kocione plocice',
        'Set prednjih kocionih plocica za Volkswagen Golf 7.',
        'Brembo',
        4200.00,
        12,
        '/images/parts/brake-pads.jpg',
        TRUE
    ),
    (
        (SELECT id FROM part_categories WHERE slug = 'filteri'),
        (SELECT id FROM vehicle_makes WHERE name = 'Opel'),
        (SELECT id FROM vehicle_models WHERE name = 'Astra J'),
        'FLT-ASTRAJ-OIL',
        'Filter ulja',
        'Filter ulja za Opel Astra J benzinske i dizel motore.',
        'Mann Filter',
        1200.00,
        30,
        '/images/parts/oil-filter.jpg',
        TRUE
    ),
    (
        (SELECT id FROM part_categories WHERE slug = 'elektrika'),
        (SELECT id FROM vehicle_makes WHERE name = 'Univerzalno'),
        (SELECT id FROM vehicle_models WHERE name = 'Univerzalni deo'),
        'BAT-60AH-UNI',
        'Akumulator 60Ah',
        'Univerzalni akumulator kapaciteta 60Ah.',
        'Varta',
        8900.00,
        5,
        '/images/parts/battery.jpg',
        TRUE
    ),
    (
        (SELECT id FROM part_categories WHERE slug = 'menjac'),
        (SELECT id FROM vehicle_makes WHERE name = 'Fiat'),
        (SELECT id FROM vehicle_models WHERE name = 'Punto'),
        'CLU-PUNTO-SET',
        'Set kvacila',
        'Set kvacila za Fiat Punto. Trenutno nije na stanju.',
        'LUK',
        14500.00,
        0,
        '/images/parts/clutch-kit.jpg',
        TRUE
    );
