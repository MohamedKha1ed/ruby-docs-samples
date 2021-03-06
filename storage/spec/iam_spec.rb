# Copyright 2017 Google, Inc
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

require_relative "../iam"
require "rspec"
require "google/cloud/storage"
require "tempfile"

describe "Google Cloud Storage IAM sample" do

  before do
    @bucket_name = ENV["GOOGLE_CLOUD_STORAGE_BUCKET"]
    @storage     = Google::Cloud::Storage.new
    @project_id  = @storage.project
    @bucket      = @storage.bucket @bucket_name
    @test_role   = "roles/storage.admin"
    @test_member = "user:test@test.com"
  end

  it "can view bucket IAM members" do
    @bucket.policy do |policy|
      policy.roles[@test_role] = [@test_member]
    end

    @bucket.policy force: true
    expect(@bucket.policy.roles[@test_role]).to include @test_member

   expect {
      view_bucket_iam_members project_id: @project_id, bucket_name: @bucket_name
   }.to output(
      /#{@test_role} Members:.*#{@test_member}/
   ).to_stdout
  end

  it "can add an IAM member" do
    @bucket.policy do |policy|
      policy.roles[@test_role] = []
    end

    @bucket.policy force: true
    expect(@bucket.policy.roles[@test_role]).to eq nil

    expect {
      add_bucket_iam_member project_id:  @project_id,
                            bucket_name: @bucket_name,
                            role:        @test_role,
                            member:      @test_member
    }.to output(
      /Added #{@test_member} with role #{@test_role}/
    ).to_stdout

    @bucket.policy force: true
    expect(@bucket.policy.roles[@test_role]).to include @test_member
  end

  it "can remove an IAM member" do
    @bucket.policy do |policy|
      policy.roles[@test_role] = [@test_member]
    end

    @bucket.policy force: true
    expect(@bucket.policy.roles[@test_role]).to include @test_member

    expect {
     remove_bucket_iam_member project_id:  @project_id,
                              bucket_name: @bucket_name,
                              role:        @test_role,
                              member:      @test_member
    }.to output(
      /Removed #{@test_member} with role #{@test_role}/
    ).to_stdout

    @bucket.policy force: true
    expect(@bucket.policy.roles[@test_role]).to eq nil
  end
end
