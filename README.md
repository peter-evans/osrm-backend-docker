# osrm-backend-docker
Docker image for the Open Source Routing Machine (OSRM) [osrm-backend](https://github.com/Project-OSRM/osrm-backend).

[![](https://images.microbadger.com/badges/image/peterevans/osrm-backend.svg)](https://microbadger.com/images/peterevans/osrm-backend "Get your own image badge on microbadger.com")

## Supported tags and respective `Dockerfile` links

- [`1.0.0`, `1.0`, `latest`  (*1.0/Dockerfile*)](https://github.com/peter-evans/osrm-backend-docker/tree/master/1.0)

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

## Graph Profiles
The graph profile will default to `car`. Passing the `OSRM_GRAPH_PROFILE` environment variable allows other profiles to be set:
```bash
docker run -d -p 5000:5000 \
-e OSRM_PBF_URL='http://download.geofabrik.de/asia/maldives-latest.osm.pbf' \
-e OSRM_GRAPH_PROFILE='bicycle' \
--name osrm-backend peterevans/osrm-backend:latest
```
Available profiles are `car`,`bicycle` and `foot`.

## Persistent Storage
For a solution to persisting graph data and immutable deployments check out [osrm-backend for Kubernetes](https://github.com/peter-evans/osrm-backend-k8s).

## License

MIT License - see the [LICENSE](LICENSE) file for details