require "spec_helper"
require "./lib/kitman/athleteservice/client"
require "byebug"

RSpec.describe(::Kitman::AthleteService::Client) do
  let(:client_id) { 'ID/abcdefghij' }
  let(:client_secret) { 'SECRET/abcdefghij' }
  let(:access_token) { 'TOKEN/abcdefghij' }
  let(:argument_file) { 'spec/fixtures/data_sample.json' }
  let(:expected_body) { JSON.parse(File.read(argument_file)) }

  let(:post_response_200) do
    {
      success: true,
      code: 200,
      error: nil,
      access_token: access_token
    }.to_json
  end

  let(:post_response_400) do
    {
      success: false,
      code: 401,
      error: "Access denied",
      access_token: access_token
    }.to_json
  end

  before do
    WebMock.stub_request(:post, "https://dev-0erpan4x.us.auth0.com/oauth/token")
      .with(
        body: "{\"client_id\":\"#{client_id}\",\"client_secret\":\"#{client_secret}\",\"grant_type\":\"client_credentials\",\"audience\":\"https://athletedataservice.thesportsoffice.com\"}",
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/json',
          'User-Agent' => 'Faraday v1.10.0'
        }
      )
      .to_return(status: 200, body: post_response_200, headers: {})
  end

  describe('Test #initialize method') do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }
    subject(:client_missing_credentials) { described_class.new(client_id: '', client_secret: '') }

    it('sets initial values') do
      expect(client.client_id).to eq(client_id)
      expect(client.client_secret).to eq(client_secret)
    end

    it('missing credentials') do
      expect{ client_missing_credentials }.to raise_error("Please ensure credentials are correct.")
    end

  end

  describe('Test #all_athletes method')  do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }

    before do
      WebMock.stub_request(:get, "https://athletedataservice.azurewebsites.net/summary")
             .with(
               headers: {
                 "Authorization" => "Bearer #{access_token}",
                 'Accept' => '*/*',
                 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                 'Content-Type' => 'application/json',
                 'User-Agent' => 'Faraday v1.10.0'
               }
             )
             .to_return(status: 200, body: File.read(argument_file), headers: {})
    end

    it("Get data from the API") do
      response = client.all_athletes
      expect(response.length).to be > 0
    end
  end

  describe('Test #get_by_athlete_name') do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }

    before do
      WebMock.stub_request(:get, "https://athletedataservice.azurewebsites.net/summary")
             .with(
               headers: {
                 "Authorization" => "Bearer #{access_token}",
                 'Accept' => '*/*',
                 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                 'Content-Type' => 'application/json',
                 'User-Agent' => 'Faraday v1.10.0'
               }
             )
             .to_return(status: 200, body: File.read(argument_file), headers: {})
    end

    it("Get athlete by name") do
      athlete_name = 'Athlete 1'
      response = client.get_by_athlete_name(athlete_name)
      expect(response[0]['athlete']).to eq(athlete_name)
    end
  end
end