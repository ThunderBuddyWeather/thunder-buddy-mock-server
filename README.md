# Thunder Buddy Mock Server

This project provides a mock server for the Weatherbit API using WireMock and Docker. It allows Thunder Buddy developers to test their application against a simulated Weatherbit API without making actual API calls to the Weatherbit service.

## Features

- Docker-based WireMock server mocking the Weatherbit API
- Pre-configured API endpoints including:
  - Current weather data
  - Forecast data (daily and hourly)
  - Weather alerts
- Response templating to dynamically include request parameters
- Location-specific weather alerts based on city or zip code
- Easy setup and configuration
- CI/CD deployment to EC2 using GitHub Actions

## Prerequisites

- Docker and Docker Compose v2
- Git

## Getting Started

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/ThunderBuddyWeather/thunder-buddy-mock-server.git
   cd thunder-buddy-mock-server
   ```

2. Build and start the WireMock container:

   ```bash
   docker compose up -d
   ```

### Usage

Once running, the mock server will be available at:

```http
http://localhost:8080
```

### Available Endpoints

All endpoints mirror the Weatherbit API structure but don't require a valid API key (any value will work).

#### Current Weather

```http
GET http://localhost:8080/current?lat=38.9072&lon=-77.0369&key=any_key
```

#### Daily Forecast

```http
GET http://localhost:8080/forecast/daily?lat=38.9072&lon=-77.0369&days=2&key=any_key
```

#### Hourly Forecast

```http
GET http://localhost:8080/forecast/hourly?lat=38.9072&lon=-77.0369&hours=2&key=any_key
```

#### Weather Alerts

```http
GET http://localhost:8080/alerts?lat=38.9072&lon=-77.0369&key=any_key
```

#### Location-Specific Weather Alerts

The mock server provides location-specific weather alerts for different cities:

```http
# Beverly Hills, CA (Flash Flood Warning)
GET http://localhost:8080/beverly-hills?lat=34.0901&lon=-118.4065

# Oklahoma City, OK (Tornado Warning)
GET http://localhost:8080/oklahoma-city?lat=35.4676&lon=-97.5164

# Miami Beach, FL (Hurricane Warning)
GET http://localhost:8080/miami-beach?lat=25.7907&lon=-80.1300

# Burlington, VT (Winter Storm Warning)
GET http://localhost:8080/burlington?lat=44.4759&lon=-73.2121

# Bend, OR (Wildfire/Red Flag Warning)
GET http://localhost:8080/bend?lat=44.0582&lon=-121.3153
```

### Testing the Mock Server

You can test the server using curl:

```bash
# Test current weather
curl "http://localhost:8080/current?lat=38.9072&lon=-77.0369&key=any_key"

# Test location-specific alerts
curl "http://localhost:8080/miami-beach?lat=25.7907&lon=-80.1300"
```

Or using a tool like Postman or Insomnia.

## Deployment

### Deploying to EC2 with GitHub Actions

This repository includes a GitHub Actions workflow to automatically deploy to an EC2 instance when pushing to the main branch.

#### Required GitHub Secrets

Set up the following secrets in your GitHub repository:

- `EC2_HOST`: The public IP or DNS of your EC2 instance
- `EC2_USERNAME`: The SSH username (typically `ec2-user` or `ubuntu`)
- `EC2_SSH_KEY`: The private SSH key for connecting to your instance

#### EC2 Prerequisites

Ensure your EC2 instance has:
- Docker and Docker Compose installed
- Git installed
- Proper security group allowing inbound traffic on port 8080

#### How It Works

The deployment workflow uses a custom GitHub action to:
1. Validate all required inputs
2. Set up a secure SSH connection to your EC2 instance
3. Copy all necessary files to the EC2 instance
4. Deploy the container using Docker Compose
5. Perform a health check to verify the deployment
6. Report detailed logs in case of failure

The workflow maintains existing data since it only replaces configuration files and restarts the containers.

## Customizing the Mock Server

### Adding New Mappings

To add or modify API responses:

1. Add or edit JSON files in the `mappings` directory
2. Add response files in the `__files` directory
3. Restart the WireMock container:

   ```bash
   docker compose restart
   ```

### Response Templating

WireMock supports templates in responses using Handlebars syntax. This allows generating dynamic responses based on request parameters.

Example usage in our mappings:

```json
"lat": "{{request.query.lat}}",
"lon": "{{request.query.lon}}"
```

## Development

### Adding Additional Endpoints

1. Create a new JSON file in the `mappings` directory
2. Create a response file in the `__files` directory
3. Define the request matching criteria and response
4. Restart the container

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 