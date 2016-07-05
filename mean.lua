local function run(msg, matches)
  local htp = http.request('http://api.vajehyab.com/v2/public/?q='..URL.escape(matches[1]))
  local data = json:decode(htp)
	return 'word : '..(data.data.title or data.search.q)..'\n\nmean: '..(data.data.text or '----' )..'\n\n sourcse : '..(data.data.source or '----' )..'\n\n'..(data.error.message or '')..'\n\n@F80_CH'
end
return {
  patterns = {
    "^[Mm][Ee][Aa][Nn] (.*)$",
    "^[Tt][Rr] (.*)$"
  },
  run = run
}