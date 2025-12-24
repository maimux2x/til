require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'httpx'
  gem 'rspec'
  gem 'webmock'
end

require 'rspec/autorun'
require 'webmock/rspec'

require 'httpx'
require 'httpx/adapters/webmock'

WebMock.disable_net_connect!

RSpec.describe WebMock do
  example do
    stub_request :get, 'example.com'

    res = HTTPX.get('http://example.com')

    expect(res.status).to eq(200)

    expect(WebMock).to have_requested(:get, 'http://example.com')
  end

  example do
    stub_request :post, 'example.com'

    res = HTTPX.post('http://example.com', json: { foo: 'bar' })

    expect(res.status).to eq(200)

    expect(WebMock).to have_requested(:post, 'http://example.com').with(
      body: {
        foo: 'bar'
      }
    )
  end

  example do
    stub_request :post, 'example.com'

    res = HTTPX.post('http://example.com', json: { foo: 'bar' })
    res = HTTPX.post('http://example.com', json: { baz: 'piyo' })

    expect(res.status).to eq(200)

    expect(WebMock).to have_requested(:post, 'http://example.com').with(
      body: {
        foo: 'bar'
      }
    )

    expect(WebMock).to have_requested(:post, 'http://example.com').with(
      body: {
        baz: 'piyo'
      }
    )
  end

  example do
    stub_request(:post, 'example.com').to_return_json(
      {
        body: {
          code: 'CODE1'
        }
      },
      {
        body: {
          type: 'TYPE1'
        }
      }
    )

    res = HTTPX.post('http://example.com', json: { foo: 'bar' })
    res = HTTPX.post('http://example.com', json: { baz: 'piyo' })

    expect(res.status).to eq(200)

    expect(WebMock).to have_requested(:post, 'http://example.com').with(
      body: {
        foo: 'bar'
      }
    )

    expect(WebMock).to have_requested(:post, 'http://example.com').with(
      body: {
        baz: 'piyo'
      }
    )
  end
end
