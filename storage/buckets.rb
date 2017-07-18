# Copyright 2016 Google, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

def list_buckets project_id:
  # [START list_buckets]
  # project_id = "Your Google Cloud project ID"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id

  storage.buckets.each do |bucket|
    puts bucket.name
  end
  # [END list_buckets]
end

def create_bucket project_id:, bucket_name:
  # [START create_bucket]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Name of Google Cloud Storage bucket to create"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.create_bucket bucket_name

  puts "Created bucket: #{bucket.name}"
  # [END create_bucket]
end

def create_bucket_with_class_location project_id:, bucket_name:, location:, storage_class:
  # [START storage_create_bucket_class_location]
  # project_id    = "Your Google Cloud project ID"
  # bucket_name   = "Name of Google Cloud Storage bucket to create"
  # location      = "Location of your Google Cloud Storage bucket"
  # storage_class = "Storage class of your Google Cloud Storage bucket"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.create_bucket bucket_name,
                                  location: location,
                                  storage_class: storage_class

  puts "Created bucket #{bucket.name} in #{location} with #{storage_class} class"
  # [END storage_create_bucket_class_location]
end

def view_location_and_class project_id:, bucket_name:
  # [START storage_get_bucket_class_and_location]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Name of your Google Cloud Storage bucket"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  puts "Located in #{bucket.location} with storage class #{bucket.storage_class}"
  # [END storage_get_bucket_class_and_location]
end

def enables_bucket_web_configuration project_id:, bucket_name:, home_page:, not_found_page:
  # [START enables_bucket_web_configuration]
  # project_id     = "Your Google Cloud project ID"
  # bucket_name    = "Name of your Google Cloud Storage bucket"
  # home_page      = "Cloud Storage file in your bucket used as a homepage"
  # not_found_page = "Cloud Storage file in your bucket used as a not found page"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  bucket.website_main = home_page
  bucket.website_404  = not_found_page

  puts "#{bucket_name} uses hompage as #{home_page} and not found page as #{not_found_page}"
  # [END enables_bucket_web_configuration]
end

def enable_file_versioning project_id:, bucket_name:
  # [START enable_versioning]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Name of your Google Cloud Storage bucket"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  bucket.versioning = true

  puts "Versioning is enabled for #{bucket_name}"
  # [END enable_versioning]
end

def disable_file_versioning project_id:, bucket_name:
  # [START disable_versioning]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Name of your Google Cloud Storage bucket"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  bucket.versioning = false

  puts "Versioning is disabled for #{bucket_name}"
  # [END disable_versioning]
end

def disable_file_versioning project_id:, bucket_name:
  # [START disable_versioning]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Name of your Google Cloud Storage bucket"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  bucket.versioning = false

  puts "Versioning is disabled for #{bucket_name}"
  # [END disable_versioning]
end

def check_file_versioning project_id:, bucket_name:
  # [START view_versioning_status]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Name of your Google Cloud Storage bucket"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  if bucket.versioning
    puts "Versioning is enabled for #{bucket_name}"
  else
    puts "Versioning is disabled for #{bucket_name}"
  # [END disable_versioning]
end

def bucket_labels project_id:, bucket_name:
  # [START get_bucket_labels]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Name of your Google Cloud Storage bucket"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  bucket.labels.each do |key, value|
    puts "#{key} = #{value}"
  end
  # [END get_bucket_labels]
end

def bucket_add_bucket_label project_id:, bucket_name:, label_key:, label_value:
  # [START add_bucket_label]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Name of your Google Cloud Storage bucket"
  # label_key   = "Cloud Storage bucket Label Key"
  # label_value = "Cloud Storage bucket Label Value"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  bucket.update do |bucket|
    bucket.labels[label_key] = label_value
  end

  puts "Added #{label_key} with value #{label_value} to labels for bucket #{bucket_name}"
  # [END add_bucket_label]
end

def bucket_remove_bucket_label project_id:, bucket_name:, label_key:
  # [START remove_bucket_label]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Name of your Google Cloud Storage bucket"
  # label_key   = "Cloud Storage bucket Label Key"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  bucket.update do |bucket|
    bucket.labels.delete label_key
  end

  puts "Removed #{label_key} from labels for bucket #{bucket_name}"
  # [END remove_bucket_label]

def delete_bucket project_id:, bucket_name:
  # [START delete_bucket]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Name of your Google Cloud Storage bucket to delete"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  bucket.delete

  puts "Deleted bucket: #{bucket.name}"
  # [END delete_bucket]
end

if __FILE__ == $0
  case ARGV.shift
  when "list"
    list_buckets project_id: ENV["GOOGLE_CLOUD_PROJECT"]
  when "create"
    create_bucket project_id:  ENV["GOOGLE_CLOUD_PROJECT"],
                  bucket_name: ARGV.shift
  when "create_with_class_and_location"
    create_bucket_with_class_location project_id:    ENV["GOOGLE_CLOUD_PROJECT"],
                                      bucket_name:   ARGV.shift,
                                      location:      ARGV.shift,
                                      storage_class: ARGV.shift
  when "delete"
    delete_bucket project_id:  ENV["GOOGLE_CLOUD_PROJECT"],
                  bucket_name: ARGV.shift
  else
    puts <<-usage
Usage: bundle exec ruby buckets.rb [command] [arguments]

Commands:
  list               List all buckets in the authenticated project
  create <bucket>    Create a new bucket with the provided name
  create_with_class_and_location <bucket> <location> <storage_class> Create a new bucket with a location and storage class.
  delete <bucket>    Delete bucket with the provided name

Environment variables:
  GOOGLE_CLOUD_PROJECT must be set to your Google Cloud project ID
    usage
  end
end
