# All the tests in this group cover matching of the 'relation' field in List()
# requests.

test_group: {
  name: 'comptest4101: Matching relation strings.'
  web_content: {
    url: 'https://comptest4101.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls", "delegate_permission/common.share_login_creds"], '
          '  "target": {"namespace": "web", "site":"https://target-comptest4101.digitalassetlinks.org" }}, '
          ' {"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target": {"namespace": "web", "site":"https://target2-comptest4101.digitalassetlinks.org" }}]'
  }

  list_statements_tests: {
    name: 'relation matches (1)'
    request: {
      source: { web: { site: 'https://comptest4101.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
    response: {
      source { web { site: "https://comptest4101.digitalassetlinks.org." } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target-comptest4101.digitalassetlinks.org." } }
    }
    response: {
      source { web { site: "https://comptest4101.digitalassetlinks.org." } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target2-comptest4101.digitalassetlinks.org." } }
    }
  }

  list_statements_tests: {
    name: 'relation matches (2)'
    request: {
      source: { web: { site: 'https://comptest4101.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.share_login_creds'
    }
    outcome: SUCCESS
    response: {
      source { web { site: "https://comptest4101.digitalassetlinks.org." } }
      relation: "delegate_permission/common.share_login_creds"
      target { web { site: "https://target-comptest4101.digitalassetlinks.org." } }
    }
  }

  list_statements_tests: {
    name: 'no relation given - all should match'
    request: {
      source: { web: { site: 'https://comptest4101.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: {
      source { web { site: "https://comptest4101.digitalassetlinks.org." } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target-comptest4101.digitalassetlinks.org." } }
    }
    response: {
      source { web { site: "https://comptest4101.digitalassetlinks.org." } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target2-comptest4101.digitalassetlinks.org." } }
    }
    response: {
      source { web { site: "https://comptest4101.digitalassetlinks.org." } }
      relation: "delegate_permission/common.share_login_creds"
      target { web { site: "https://target-comptest4101.digitalassetlinks.org." } }
    }
  }

  list_statements_tests: {
    name: 'Relation query with wildcard'
    request: {
      source: { web: { site: 'https://comptest4101.digitalassetlinks.org' } }
      relation: 'delegate_permission/*'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  list_statements_tests: {
    name: 'relation does not match (1)'
    request: {
      source: { web: { site: 'https://comptest4101.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.other'
    }
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'relation does not match (2)'
    request: {
      source: { web: { site: 'https://comptest4101.digitalassetlinks.org' } }
      relation: 'navigate/common.handle_all_urls'
    }
    outcome: SUCCESS
  }
}
