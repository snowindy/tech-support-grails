<%@ page import="org.springframework.util.ClassUtils" %>
<%@ page import="org.codehaus.groovy.grails.plugins.searchable.SearchableUtils" %>
<%@ page import="org.codehaus.groovy.grails.plugins.searchable.lucene.LuceneUtils" %>
<%@ page import="org.codehaus.groovy.grails.plugins.searchable.util.StringQueryUtils" %>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main" />
    <title><g:if test="${params.q && params.q?.trim() != ''}">${params.q} - </g:if>Поиск по сайту</title>
    <style type="text/css">


      #header .hint {
        color: gray;
      }
      #header form {
        padding-top: .1em;
      }

      .title {
        margin: 1em 0;
        padding: .3em .5em;
        text-align: right;
        background-color: seashell;
        border-top: 1px solid lightblue;
      }

      .result {
        margin-bottom: 1em;
      }

      .result .displayLink a {
        color: green;
        font-weight: normal;
      }

      .result .name {
        font-size: larger;
      }

      .paging a.step {
        padding: 0 .3em;
      }

      .paging span.currentStep {
        font-weight: bold;
      }

      ul {
        margin: 1em 2em;
      }

      li, p {
        margin-bottom: 1em;
      }
    </style>
    <script type="text/javascript">
        var focusQueryInput = function() {
            document.getElementById("q").focus();
        }
    </script>
  </head>
  <body onload="focusQueryInput();">
    <div class="body">

      <div id="header">
        <h1>Поиск по сайту</h1>
        <g:form url='[controller: "searchable", action: "index"]' id="searchableForm" name="searchableForm" method="get">
          <g:textField name="q" value="${params.q}" size="50"/> <input type="submit" value="Поиск" />
          <g:hiddenField name="suggestQuery" value="true" />
        </g:form>

      </div>

      <div id="main">
        <g:set var="haveQuery" value="${params.q?.trim()}" />
        <g:set var="haveResults" value="${searchResult?.results}" />
        <div class="title">
          <span>
            <g:if test="${haveQuery && haveResults}">
              Результаты: <strong>${searchResult.offset + 1}</strong> - <strong>${searchResult.results.size() + searchResult.offset}</strong> из <strong>${searchResult.total}</strong>
              для запроса <strong>${params.q}</strong>
            </g:if>
            <g:else>
              &nbsp;
            </g:else>
          </span>
        </div>

        <g:if test="${searchResult?.suggestedQuery}">
          <p>Возможно, Вы имели ввиду <g:link controller="searchable" action="index" params="[q: searchResult.suggestedQuery]">${StringQueryUtils.highlightTermDiffs(params.q.trim(), searchResult.suggestedQuery)}</g:link>?</p>
        </g:if>

        <g:if test="${parseException}">
          <p>Your query - <strong>${params.q}</strong> - is not valid.</p>
          <p>Suggestions:</p>
          <ul>
            <li>Fix the query: see <a href="http://lucene.apache.org/java/docs/queryparsersyntax.html">Lucene query syntax</a> for examples</li>
            <g:if test="${LuceneUtils.queryHasSpecialCharacters(params.q)}">
              <li>Remove special characters like <strong>" - [ ]</strong>, before searching, eg, <em><strong>${LuceneUtils.cleanQuery(params.q)}</strong></em><br />
                <em>Use the Searchable Plugin's <strong>LuceneUtils#cleanQuery</strong> helper method for this: <g:link controller="searchable" action="index" params="[q: LuceneUtils.cleanQuery(params.q)]">Search again with special characters removed</g:link></em>
              </li>
              <li>Escape special characters like <strong>" - [ ]</strong> with <strong>\</strong>, eg, <em><strong>${LuceneUtils.escapeQuery(params.q)}</strong></em><br />
                <em>Use the Searchable Plugin's <strong>LuceneUtils#escapeQuery</strong> helper method for this: <g:link controller="searchable" action="index" params="[q: LuceneUtils.escapeQuery(params.q)]">Search again with special characters escaped</g:link></em><br />
                <em>Or use the Searchable Plugin's <strong>escape</strong> option: <g:link controller="searchable" action="index" params="[q: params.q, escape: true]">Search again with the <strong>escape</strong> option enabled</g:link></em>
              </li>
            </g:if>
          </ul>
        </g:if>

        <g:if test="${haveResults}">
          <div class="results">
            <g:each var="result" in="${searchResult.results}" status="index">
              <div class="result">
                <g:set var="className" value="${ClassUtils.getShortName(result.getClass())}" />
                <g:set var="link" value="${createLink(controller: className[0].toLowerCase() + className[1..-1], action: 'show', id: result.id)}" />
                <div class="name displayLink"><a href="${link}">${result.title}</a></div>
                <g:set var="desc" value="${result.descr}" />
                <g:if test="${desc.size() > 120}"><g:set var="desc" value="${desc[0..120] + '...'}" /></g:if>
                <div class="desc">${desc}</div>
              </div>
            </g:each>
          </div>

          <div>
            <div class="paging">
              <g:if test="${haveResults}">
                Страница:
                <g:set var="totalPages" value="${Math.ceil(searchResult.total / searchResult.max)}" />
                <g:if test="${totalPages == 1}"><span class="currentStep">1</span></g:if>
                <g:else><g:paginate controller="searchable" action="index" params="[q: params.q]" total="${searchResult.total}" prev="&lt; previous" next="next &gt;"/></g:else>
              </g:if>
            </div>
          </div>
        </g:if>
      </div>
    </div>


  </body>
</html>
