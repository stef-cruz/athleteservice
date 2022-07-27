require 'spec_helper'
require './lib/kitman/athlete_service/client'
require 'byebug'

RSpec.describe(::Kitman::AthleteServiceAPI::Client) do
  let(:client_id) { 'ID/abcdefghij' }
  let(:client_secret) { 'SECRET/abcdefghij' }
  let(:access_token) { 'TOKEN/abcdefghij' }
  let(:argument_file) { 'spec/fixtures/data_sample.json' }
  let(:expected_body) { JSON.parse(File.read(argument_file)) }

  let(:response_200) do
    {
      success: true,
      code: 200,
      error: nil,
      access_token: access_token
    }.to_json
  end

  let(:response_401) do
    {
      success: false,
      code: 401,
      error: 'Access denied'
    }.to_json
  end

  before do
    WebMock.stub_request(:post, 'https://dev-0erpan4x.us.auth0.com/oauth/token')
           .with(
             body: "{\"client_id\":\"#{client_id}\",\"client_secret\":\"#{client_secret}\",\"grant_type\":\"client_credentials\",\"audience\":\"https://athletedataservice.thesportsoffice.com\"}",
             headers: {
               'Accept' => '*/*',
               'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
               'Content-Type' => 'application/json',
               'User-Agent' => 'Faraday v1.10.0'
             }
      )
           .to_return(status: 200, body: response_200, headers: {})
  end

  describe('Test #initialize') do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }
    subject(:client_missing_credentials) { described_class.new(client_id: '', client_secret: '') }

    it('sets initial values') do
      expect(client.client_id).to eq(client_id)
      expect(client.client_secret).to eq(client_secret)
    end

    it('missing credentials') do
      expect { client_missing_credentials }.to raise_error('Please ensure credentials are correct.')
    end
  end

  describe('Test #all_athletes - Successfully fetching data from API') do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }

    before do
      WebMock.stub_request(:get, 'https://athletedataservice.azurewebsites.net/summary')
             .with(
               headers: {
                 'Authorization' => "Bearer #{access_token}",
                 'Accept' => '*/*',
                 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                 'Content-Type' => 'application/json',
                 'User-Agent' => 'Faraday v1.10.0'
               }
             )
             .to_return(status: 200, body: File.read(argument_file), headers: {})
    end

    it('Get data from the API') do
      response = client.all_athletes
      expect(response.length).to be > 0
    end
  end

  describe('Test #all_athletes - Failing to fetch data from API') do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }

    before do
      WebMock.stub_request(:get, 'https://athletedataservice.azurewebsites.net/summary')
             .with(
               headers: {
                 'Authorization' => "Bearer #{access_token}",
                 'Accept' => '*/*',
                 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                 'Content-Type' => 'application/json',
                 'User-Agent' => 'Faraday v1.10.0'
               }
             )
             .to_return(status: 401, body: response_401, headers: {})
    end

    it('Fail to get data from the API') do
      response = client.all_athletes
      expect(response['success']).to eq(false)
      expect(response['code']).to eq(401)
    end
  end


  describe('Test #athlete_by_name') do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }

    before do
      WebMock.stub_request(:get, 'https://athletedataservice.azurewebsites.net/summary')
             .with(
               headers: {
                 'Authorization' => "Bearer #{access_token}",
                 'Accept' => '*/*',
                 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                 'Content-Type' => 'application/json',
                 'User-Agent' => 'Faraday v1.10.0'
               }
             )
             .to_return(status: 200, body: File.read(argument_file), headers: {})
    end

    it('Get athlete by name') do
      athlete_name = 'Athlete 1'
      response = client.athlete_by_name(athlete_name)
      expect(response[0]['athlete']).to eq(athlete_name)
    end
  end

  describe('Test #athletes_average_summary') do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }

    before do
      WebMock.stub_request(:get, 'https://athletedataservice.azurewebsites.net/summary')
             .with(
               headers: {
                 'Authorization' => "Bearer #{access_token}",
                 'Accept' => '*/*',
                 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                 'Content-Type' => 'application/json',
                 'User-Agent' => 'Faraday v1.10.0'
               }
             )
             .to_return(status: 200, body: File.read(argument_file), headers: {})
    end

    it('Get average of summary') do
      response = client.athletes_average_summary
      expect(response[0]).to have_key(:average)
    end
  end
end
