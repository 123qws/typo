Feature: Merge aritcle
  As a blog administrator
  In order to reduce same contents of blogs
  I want to be able to merge article

  Background:
    Given the blog is set up
    Given a blogger is created
    Given the following contents exist:
    | title | author | body             | published | id |
    | braid | sw     | I am a publisher | t         |  2 | 
    | limbo | gxy    | I love this game | t         |  3 |
    
  Scenario: A non-admin cannot merge two articles
    When a blogger is logged into the admin panel
    Given I am on the new article page
    When I fill in "article_title" with "Foobar"
    And I fill in "article__body_and_extended_editor" with "Lorem Ipsum"
    And I press "Publish"
    Then I should be on the admin content page
    And I follow "Foobar"
    And show me the page
    Then I should not see "Merge Articles"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    When I am logged into the admin panel
    When I am on the content page    
    And I follow "braid"
    Then I should see "Merge Articles"
    Then I fill in "merge_with" with "3"
    And I press "Merge"
    Then I should be on the content page
    And I should see "braid"
    And I should not see "limbo"
    Then I follow "braid"
    Then I should see "I am a publisherI love this game"
    And show me the page
  