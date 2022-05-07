provider "google" {
  credentials = file("key2.json")
  project = "terraform-348208"
  region = "asia-northeast3"
}

resource "google_storage_bucket" "terraform_state" {

  # 버킷 이름
  name = "terraform-up-and-running-state-0d9027ef04cb8b9b"

  # 버킷을 삭제할 때 해당 버킷에 포함된 모든 객체를 삭제합니다.
  force_destroy = true

  location = "ASIA"

  storage_class = "Standard"

  # 실수로 S3 버킷을 삭제하는 것을 방지합니다.(생명주기 설정)
  lifecycle {
    prevent_destroy = true
  }

  # 코드 이력을 관리하기 위해 상태 파일의 버전 관리를 활성화합니다.
  versioning {
    enabled = false
  }

  // GCP는 스토리지 디폴트가 암호화

}

terraform {
  backend "gcs" {
    bucket = "terraform-up-and-running-state-0d9027ef04cb8b9b"
    credentials = "key2.json"
  }
}
