REM   Script: flights
REM   script to build star scheme

CREATE TABLE time
(
    time_id     NUMBER,
    day         NUMBER,
    month       NUMBER,
    year        NUMBER,
    day_of_week NUMBER,
    hour        NUMBER,
    minute      NUMBER,
    constraint pk_time primary key (time_id)
);

CREATE TABLE airline
(
    iata_code NCHAR(2),
    name      NVARCHAR2(50),
    constraint pk_airline primary key (iata_code)
);

CREATE TABLE airport
(
    iata_code NCHAR(3),
    airport   NVARCHAR2(50),
    city      NVARCHAR2(50),
    state     NVARCHAR2(50),
    country   NVARCHAR2(50),
    longitude FLOAT,
    latitude  FLOAT,
    constraint pk_airport primary key (iata_code)
);

CREATE TABLE cancellation
(
    cancellation_id  NUMBER,
    cancelled_reason NCHAR(1),
    constraint pk_cancellation primary key (cancellation_id)
);

CREATE TABLE flight
(
    flight_id           NUMBER,
    airline             NCHAR(2),
    original_airport    NCHAR(3),
    destination_airport NCHAR(3),
    departure_time      NUMBER,
    arrival_time        NUMBER,
    wheels_on           NUMBER,
    wheels_off          NUMBER,
    scheduled_departure NUMBER,
    scheduled_arrival   NUMBER,
    cancellation_id     NUMBER,
    flight_number       NUMBER,
    cancelled           NUMBER(1),
    departure_delay     NUMBER,
    arrival_delay       NUMBER,
    tail_number         NCHAR(6),
    elapsed_time        NUMBER,
    distance            NUMBER,
    diverted            NUMBER,
    taxi_in             NUMBER,
    taxi_out            NUMBER,
    air_system_delay    NUMBER,
    security_delay      NUMBER,
    airline_delay       NUMBER,
    late_aircraft_delay NUMBER,
    weather_delay       NUMBER,

    constraint pk_flight primary key (flight_id),
    constraint fk_flight_airline foreign key (airline)
        references airline (iata_code),
    constraint fk_flight_ori_airport foreign key (original_airport)
        references airport (iata_code),
    constraint fk_flight_des_airport foreign key (destination_airport)
        references airport (iata_code),
    constraint fk_flight_dpt_time foreign key (departure_time)
        references time (time_id),
    constraint fk_flight_arv_time foreign key (arrival_time)
        references time (time_id),
    constraint fk_flight_wheels_on foreign key (wheels_on)
        references time (time_id),
    constraint fk_flight_wheels_off foreign key (wheels_off)
        references time (time_id),
    constraint fk_flight_scd_dpt foreign key (scheduled_departure)
        references time (time_id),
    constraint fk_flight_scd_arv foreign key (scheduled_arrival)
        references time (time_id),
    constraint fk_flight_cancell foreign key (cancellation_id)
        references cancellation (cancellation_id)
);

CREATE DIMENSION time_dimension
    LEVEL minute IS (time.minute)
    LEVEL hour IS (time.hour)
    LEVEL day IS (time.day)
    LEVEL day_of_week IS (time.day_of_week)
    LEVEL month IS (time.month)
    LEVEL year IS (time.year)
    HIERARCHY time_day_rollup (
        minute CHILD OF
        hour CHILD OF
        day CHILD OF
        month CHILD OF
        year )
    HIERARCHY time_day_of_week_rollup (
        minute CHILD OF
        hour CHILD OF
        day_of_week CHILD OF
        month CHILD OF
        year );

CREATE DIMENSION airport_dimension
    LEVEL country IS (airport.country)
    LEVEL state IS (airport.state)
    LEVEL city IS (airport.city)
    LEVEL airport IS (airport.airport)
    LEVEL longitude IS (airport.longitude)
    LEVEL latitude IS (airport.latitude)
    HIERARCHY airport_rollup (
        airport CHILD OF
        city CHILD OF
        state CHILD OF
        country)
    HIERARCHY airport_long_rollup (
        airport CHILD OF
        longitude)
    HIERARCHY airport_lat_rollup (
        airport CHILD OF
        latitude);

CREATE DIMENSION airline_dimension
    LEVEL name IS (airline.name);

CREATE DIMENSION cancellation_dimension
    LEVEL cancelled_reason IS (cancellation.cancelled_reason);

