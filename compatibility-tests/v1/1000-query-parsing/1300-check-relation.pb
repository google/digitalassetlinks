# All the test cases in this group cover parsing of relation queries of Check()
# requests.  Note that parsing errors should cause the API to abort the request
# immediately.

test_group: {
  name: 'comptest1301: relation queries in Check requests'

  web_content: {
    url: 'https://source-comptest1301.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[]'
  }

  # First a few valid queries.
  check_statements_tests: {
    name: 'Valid relation query (1)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission/write_on_the_walls'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Valid relation query (2)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission/org.digitalassetlinks.write_on_the_walls'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Valid relation query (3)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Valid relation query (4)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'navigate/yellow_brick_road'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Valid relation query (5)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission/get_login_creds'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
  }

  # Now some invalid queries.
  check_statements_tests: {
    name: 'Missing relation query'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Request must contain a relation string'
  }

  check_statements_tests: {
    name: 'Empty relation query'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: ''
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Request must contain a relation string'
  }

  check_statements_tests: {
    name: 'Relation query with wildcard'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission/*'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  check_statements_tests: {
    name: 'Relation query with invalid kind (1)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'INVALID_KIND/write_on_the_walls'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }

  check_statements_tests: {
    name: 'Relation query with invalid kind (2)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: '/write_on_the_walls'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }

  check_statements_tests: {
    name: 'Relation query with invalid kind (3)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: '/'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }

  check_statements_tests: {
    name: 'Invalid relation query (1)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'write_on_the_walls'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid relation string'
  }

  check_statements_tests: {
    name: 'Invalid relation query (2)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid relation string'
  }

  check_statements_tests: {
    name: 'Invalid relation query (3)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission/write_on_the_walls/foo'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid relation string'
  }

  check_statements_tests: {
    name: 'Invalid relation query (4)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission,write_on_the_walls'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid relation string'
  }

  check_statements_tests: {
    name: 'Relation query with invalid detail (1)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission/'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  check_statements_tests: {
    name: 'Relation query with invalid detail (2)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission/write on the walls'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  check_statements_tests: {
    name: 'Relation query with invalid detail (3)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission/write+on+the+walls'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  check_statements_tests: {
    name: 'Relation query with invalid detail (4)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission/write_on_the_walls!'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  check_statements_tests: {
    name: 'Relation query with invalid detail (5)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission/write_on_the_WALLS'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  check_statements_tests: {
    name: 'Relation query with spurious whitespace (1)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission/write_on_the_walls '
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  check_statements_tests: {
    name: 'Relation query with spurious whitespace (2)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: ' delegate_permission/write_on_the_walls'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }

  check_statements_tests: {
    name: 'Relation query with spurious whitespace (3)'
    request: {
      source: { web: { site: 'https://source-comptest1301.digitalassetlinks.org' } }
      relation: 'delegate_permission / write_on_the_walls'
      target: { web: { site: 'https://target-comptest1301.digitalassetlinks.org' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }
}
