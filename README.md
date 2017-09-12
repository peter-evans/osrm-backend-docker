# osrm-backend-docker
[![](https://images.microbadger.com/badges/image/peterevans/osrm-backend.svg)](https://microbadger.com/images/peterevans/osrm-backend)
[![Build Status](https://travis-ci.org/peter-evans/osrm-backend-docker.svg?branch=master)](https://travis-ci.org/peter-evans/osrm-backend-docker)

Docker image for the Open Source Routing Machine (OSRM) [osrm-backend](https://github.com/Project-OSRM/osrm-backend).

## Supported tags and respective `Dockerfile` links

- [`1.9.0`, `1.9`, `latest`  (*1.9/Dockerfile*)](https://github.com/peter-evans/osrm-backend-docker/tree/master/1.9)
- [`1.9.0-trusty`, `1.9-trusty`, `trusty`  (*1.9/trusty/Dockerfile*)](https://github.com/peter-evans/osrm-backend-docker/tree/master/1.9/trusty)
- [`1.8.0`, `1.8` (*1.8/Dockerfile*)](https://github.com/peter-evans/osrm-backend-docker/tree/master/1.8)
- [`1.8.0-trusty`, `1.8-trusty` (*1.8/trusty/Dockerfile*)](https://github.com/peter-evans/osrm-backend-docker/tree/master/1.8/trusty)
- [`1.7.0`, `1.7` (*1.7/Dockerfile*)](https://github.com/peter-evans/osrm-backend-docker/tree/master/1.7)
- [`1.7.0-trusty`, `1.7-trusty` (*1.7/trusty/Dockerfile*)](https://github.com/peter-evans/osrm-backend-docker/tree/master/1.7/trusty)
- [`1.6.0`, `1.6` (*1.6/Dockerfile*)](https://github.com/peter-evans/osrm-backend-docker/tree/master/1.6)
- [`1.6.0-trusty`, `1.6-trusty` (*1.6/trusty/Dockerfile*)](https://github.com/peter-evans/osrm-backend-docker/tree/master/1.6/trusty)
- [`1.5.0`, `1.5` (*1.5/Dockerfile*)](https://github.com/peter-evans/osrm-backend-docker/tree/master/1.5)
- [`1.5.0-trusty`, `1.5-trusty` (*1.5/trusty/Dockerfile*)](https://github.com/peter-evans/osrm-backend-docker/tree/master/1.5/trusty)

For earlier versions check the repository and the available [tags on Docker Hub](https://hub.docker.com/r/peterevans/osrm-backend/tags/).

## Usage
Pass the `OSRM_PBF_URL` environment variable to the container referencing the URL of your PBF file:

```bash
docker run -d -p 5000:5000 \
-e OSRM_PBF_URL='http://download.geofabrik.de/asia/maldives-latest.osm.pbf' \
--name osrm-backend peterevans/osrm-backend:latest
```
The PBF file will be downloaded and the graph will begin building. Note that very large graphs may take hours to be built.

Tail the logs to verify the graph has been built and osrm-backend is serving requests:
```
docker logs -f <CONTAINER ID>
```
Then point your web browser to [http://localhost:5000/](http://localhost:5000/)

For API documentation see [http://project-osrm.org/docs/v5.10.0/api/](http://project-osrm.org/docs/v5.10.0/api/)

## Graph Profiles
The graph profile will default to `car`. Other profiles can be specified with the `OSRM_GRAPH_PROFILE` environment variable:
```bash
docker run -d -p 5000:5000 \
-e OSRM_PBF_URL='http://download.geofabrik.de/asia/maldives-latest.osm.pbf' \
-e OSRM_GRAPH_PROFILE='bicycle' \
--name osrm-backend peterevans/osrm-backend:latest
```
Available profiles are `car`,`bicycle` and `foot`.

## Custom Graph Profiles
The URL to a custom graph profile can be passed via the `OSRM_GRAPH_PROFILE_URL` environment variable. If this variable is set it will override any profile set by `OSRM_GRAPH_PROFILE`.
```bash
docker run -d -p 5000:5000 \
-e OSRM_PBF_URL='http://download.geofabrik.de/asia/maldives-latest.osm.pbf' \
-e OSRM_GRAPH_PROFILE_URL='https://raw.githubusercontent.com/peter-evans/osrm-backend-docker/master/tests/car.lua' \
--name osrm-backend peterevans/osrm-backend:latest
```

## Data Storage Location
By default the graph will be built and stored at the path `/osrm-data`. A custom path can be specified with the `OSRM_DATA_PATH` environment variable. Note that the path should NOT contain a trailing slash (`/`).
```bash
docker run -d -p 5000:5000 \
-e OSRM_PBF_URL='http://download.geofabrik.de/asia/maldives-latest.osm.pbf' \
-e OSRM_DATA_PATH='/my-custom-path' \
--name osrm-backend peterevans/osrm-backend:latest
```

## Persistent Storage
For a solution to persisting graph data and immutable deployments check out [osrm-backend for Kubernetes](https://github.com/peter-evans/osrm-backend-k8s).

## License

MIT License - see the [LICENSE](LICENSE) file for details
