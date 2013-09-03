{expect} = require 'chai'

MWM = require '../src/wiki-mark'

describe 'MicroWikiMark', ->

  mwm = null
  before ->
    mwm = MWM()

  it 'does not change normal text', ->
    expect(mwm.compile '').to.equal ''
    expect(mwm.compile 'abc').to.equal 'abc'
    expect(mwm.compile 'foo\nbar').to.equal 'foo\nbar'

  it 'compiles simple links', ->
    expect(mwm.compile '[[abc]]').to.equal '<a href="abc">abc</a>'

  it 'compiles complex links', ->
    expect(mwm.compile '[[Title|Target]]').to.equal '<a href="Target">Title</a>'

  it 'compiles links with leading and trailing whitespaces', ->
    expected = '<a href="Target X">Title Z</a>'
    expect(mwm.compile '[[Title Z|Target X]]').to.equal expected
    expect(mwm.compile '[[  Title Z|Target X]]').to.equal expected
    expect(mwm.compile '[[Title Z  |Target X]]').to.equal expected
    expect(mwm.compile '[[Title Z|  Target X]]').to.equal expected
    expect(mwm.compile '[[Title Z|Target X  ]]').to.equal expected
    expect(mwm.compile '[[ Title Z   |\tTarget X  ]]').to.equal expected
    expect(mwm.compile '[[ Foo ]]').to.equal '<a href="Foo">Foo</a>'

  it 'does not compile links with newlines (reserving syntax for other uses)', ->
    input = '[[a\n]]'
    expect(mwm.compile input).to.equal input

  it 'compiles multiple links', ->
    input = '[[one]][[2|two]][[three]]'
    expected = '<a href="one">one</a><a href="two">2</a><a href="three">three</a>'
    expect(mwm.compile input).to.equal expected

  it 'compiles links relative to a base', ->
    mwmWithBase = MWM base: 'http://domain/'
    expect(mwmWithBase.compile '[[x]]').to.equal '<a href="http://domain/x">x</a>'

  it 'allows for literal "[[x|y]]" and "\\" strings', ->
    expect(mwm.compile '\\[q]').to.equal '\\[q]'
    expect(mwm.compile 'a\\b').to.equal 'a\\b'
    expect(mwm.compile '\\[[x]]').to.equal '[[x]]'
    expect(mwm.compile '\\[[x|y]]').to.equal '[[x|y]]'
    expect(mwm.compile '\\[[ x | y ]]').to.equal '[[ x | y ]]'
    expect(mwm.compile '\\[[ x ]]').to.equal '[[ x ]]'
