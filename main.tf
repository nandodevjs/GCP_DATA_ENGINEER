resource "google_storage_bucket" "gcs_bucket" {
    name = "test-bucket-243r543ew"
}

module "bigquery-dataset-gasolina" {
  source = "./modules/bigquery"
  dataset_id = "GASOLINA_BRASIL"
  dataset_name = "GASOLINA_BRASIL"
  description = "Dataset com dados históricos do valor da gasolina no Brasil"
  project_id = var.project_id
  location = var.region
  delete_contents_on_destroy = true
  deletion_protection = false
  access = [
    {
      role = "OWNER"
      special_group = "projectOwners"
    },
    {
      role = "READER"
      special_group = "projectReaders"
    },
    {
      role = "WRITER"
      special_group = "projectWriters"
    }
  ]
  tables=[
    {
      table_id = "tb_historico_combustivel_brasil",
      description = "Valores dos preços do combustível ao longo dos anos"
      time_partitioning = {
        type = "DATA",
        field = "data",
        require_partition_filter = false,
        expiration_ms = null
      },
      range_partitioning = null,
      expiration_time = null,
      clustering = ["produto","regiao_sigla","estado_sigla"],
      labels = {
        name = "ELT_Combustivel"
        project = "gasolina"
      },
      deletion_protections = true
      schema = file("./bigquery/schema/gasolina_brasil/tb_historico_combustivel_brasil.json")
    }
  ]
}

module "bucket-raw" {
  source = "./modules/gcs"

  name = "raw_combustivel_846152"
  project_id = var.project_id
  location = var.region
}

module "bucket-curated" {
  source = "./modules/gcs"

  name = "curated_combustivel_126435"
  project_id = var.project_id
  location = var.region
}

module "pyspark-temp" {
  source = "./modules/gcs"

  name = "pyspark_temp_combustivel_541654"
  project_id = var.project_id
  location = var.region
}

module "pyspark-code" {
  source = "./modules/gcs"

  name = "pyspark_code_combustivel_525345"
  project_id = var.project_id
  location = var.region
}   