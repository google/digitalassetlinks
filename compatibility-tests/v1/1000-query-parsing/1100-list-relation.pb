# All the test cases in this group cover parsing of relation queries of List()
# requests.  Note that parsing errors should cause the API to abort the request
# immediately.

test_group: {
  name: 'comptest1101: relation queries in List requests'

  web_content: {
    url: 'https://source-comptest1101.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[]'
  }

  # First a few valid queries.
  list_statements_tests: {
    name: 'Valid relation query (1)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission/write_on_the_walls'
    }
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Valid relation query (2)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission/org.digitalassetlinks.write_on_the_walls'
    }
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Valid relation query (3)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Valid relation query (4)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'navigate/yellow_brick_road'
    }
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Valid relation query (5)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission/get_login_creds'
    }
    outcome: SUCCESS
  }

  # Now some invalid queries.
  list_statements_tests: {
    name: 'Missing relation query'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
    }
    # No error: missing relation strings are allowed in List requests and are
    # interpreted as wilcards.
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Empty relation query'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: ''
    }
    # No error: empty relation strings are allowed in List requests and are
    # interpreted as wilcards.
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Relation query with wildcard'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission/*'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  list_statements_tests: {
    name: 'Relation query with invalid kind (1)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'INVALID_KIND/write_on_the_walls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }

  list_statements_tests: {
    name: 'Relation query with invalid kind (2)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: '/write_on_the_walls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }

  list_statements_tests: {
    name: 'Relation query with invalid kind (3)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: '/'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }

  list_statements_tests: {
    name: 'Invalid relation query (1)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'write_on_the_walls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid relation string'
  }

  list_statements_tests: {
    name: 'Invalid relation query (2)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid relation string'
  }

  list_statements_tests: {
    name: 'Invalid relation query (3)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission/write_on_the_walls/foo'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid relation string'
  }

  list_statements_tests: {
    name: 'Invalid relation query (4)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission,write_on_the_walls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid relation string'
  }

  list_statements_tests: {
    name: 'Relation query with invalid detail (1)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission/'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  list_statements_tests: {
    name: 'Relation query with invalid detail (2)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission/write on the walls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  list_statements_tests: {
    name: 'Relation query with invalid detail (3)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission/write+on+the+walls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  list_statements_tests: {
    name: 'Relation query with invalid detail (4)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission/write_on_the_walls!'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  list_statements_tests: {
    name: 'Relation query with invalid detail (5)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission/write_on_the_WALLS'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  list_statements_tests: {
    name: 'Relation query with spurious whitespace (1)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission/write_on_the_walls '
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
  }

  list_statements_tests: {
    name: 'Relation query with spurious whitespace (2)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: ' delegate_permission/write_on_the_walls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }

  list_statements_tests: {
    name: 'Relation query with spurious whitespace (3)'
    request: {
      source: { web: { site: 'https://source-comptest1101.digitalassetlinks.org' } }
      relation: 'delegate_permission / write_on_the_walls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
  }
}
