# All the tests in this group cover matching of the 'relation' field in Check()
# requests.

test_group: {
  name: 'comptest4301: Matching relation strings.'
  web_content: {
    url: 'https://comptest4301.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls", "delegate_permission/common.share_login_creds"], '
          '  "target": {"namespace": "web", "site":"https://target-comptest4301.digitalassetlinks.com" }}]'
  }

  check_statements_tests: {
    name: 'relation matches (1)'
    request: {
      source: { web: { site: 'https://comptest4301.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-comptest4301.digitalassetlinks.com' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'relation matches (2)'
    request: {
      source: { web: { site: 'https://comptest4301.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.share_login_creds'
      target: { web: { site: 'https://target-comptest4301.digitalassetlinks.com' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'Relation query with wildcard'
    request: {
      source: { web: { site: 'https://comptest4301.digitalassetlinks.org' } }
      relation: 'delegate_permission/*'
      target: { web: { site: 'https://target-comptest4301.digitalassetlinks.com' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
    response: false
  }

  check_statements_tests: {
    name: 'relation does not match (1)'
    request: {
      source: { web: { site: 'https://comptest4301.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.other'
      target: { web: { site: 'https://target-comptest4301.digitalassetlinks.com' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'relation does not match (2)'
    request: {
      source: { web: { site: 'https://comptest4301.digitalassetlinks.org' } }
      relation: 'navigate/common.handle_all_urls'
      target: { web: { site: 'https://target-comptest4301.digitalassetlinks.com' } }
    }
    outcome: SUCCESS
    response: false
  }
}
