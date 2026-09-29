CREATE TABLE IF NOT EXISTS mechanic_job_vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner VARCHAR(50) NOT NULL,
    vehicle_model VARCHAR(50) NOT NULL,
    vehicle_plate VARCHAR(10) NOT NULL,
    last_repair TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO mechanic_job_vehicles (owner, vehicle_model, vehicle_plate) VALUES ('player1', 'adder', 'ADDER1');
INSERT INTO mechanic_job_vehicles (owner, vehicle_model, vehicle_plate) VALUES ('player2', 'zentorno', 'ZENTORNO1');