resource "google_project_service" "cloudresourcemanager_googleapis_com" {
    service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "container_googleapis_com" {
    service = "container.googleapis.com"
    depends_on = [
        "google_project_service.cloudresourcemanager_googleapis_com"
    ]
}

resource "google_container_cluster" "production_cluster" {
    name = "production-cluster"
    location = "us-east1-b"
    initial_node_count = 1

    node_locations = [
        "us-east1-c"
    ]

    node_config {
        oauth_scopes = [
            "https://www.googleapis.com/auth/compute",
            "https://www.googleapis.com/auth/devstorage.read_only",
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring",
        ]

        labels = {
            dummy_label = "continuous-deployment-101" 
        }
    }

    depends_on = [
        "google_project_service.container_googleapis_com"
    ]
}


