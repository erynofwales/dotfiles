syn case ignore

syn keyword bangDirective   include account end transparent contained containedin=ledgerDirective

syn keyword periodRecurring daily weekly biweekly monthly bimonthly quarterly yearly contained containedin=ledgerPeriodEntry
syn keyword periodSingle    day week month quarter year contained containedin=periodEvery
syn keyword periodPlural    days weeks months quarters years contained containedin=periodEveryN
syn match   periodEvery	    'every\s\+' nextgroup=periodSingle
syn match   periodEveryN    'every \(\d\+\)\=\s\+' nextgroup=periodPlural

syn case match

syn match ledgerComment '^;.*'
syn match ledgerCommand '^[YPNDC]'
syn match ledgerDirective '^!' nextgroup=bangDirective
syn match ledgerPeriodEntry '^\~\s*.*'he=s contains=periodRecurring,periodEvery,periodEveryN
"syn match ledgerAutomatedEntry '^=\s*'he=s contains=valueExpression

hi def link ledgerComment Comment
hi def link ledgerCommand Keyword
hi def link ledgerDirective Special
hi def link ledgerPeriodEntry Special

hi def link periodRecurring Keyword
hi def link periodSingle Keyword
hi def link periodPlural Keyword
hi def link periodEvery Keyword
hi def link periodEveryN Keyword
