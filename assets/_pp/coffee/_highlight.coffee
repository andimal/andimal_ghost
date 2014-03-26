hljs = new ->
  k = (v) ->
    v.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace />/g, "&gt;"
  t = (v) ->
    v.nodeName.toLowerCase()
  i = (w, x) ->
    v = w and w.exec(x)
    v and v.index is 0
  d = (v) ->
    Array::map.call(v.childNodes, (w) ->
      return (if b.useBR then w.nodeValue.replace(/\n/g, "") else w.nodeValue)  if w.nodeType is 3
      return "\n"  if t(w) is "br"
      d w
    ).join ""
  r = (w) ->
    v = (w.className + " " + ((if w.parentNode then w.parentNode.className else ""))).split(/\s+/)
    v = v.map((x) ->
      x.replace /^language-/, ""
    )
    v.filter((x) ->
      j(x) or x is "no-highlight"
    )[0]
  o = (x, y) ->
    v = {}
    for w of x
      v[w] = x[w]
    if y
      for w of y
        v[w] = y[w]
    v
  u = (x) ->
    v = []
    (w = (y, z) ->
      A = y.firstChild

      while A
        if A.nodeType is 3
          z += A.nodeValue.length
        else
          if t(A) is "br"
            z += 1
          else
            if A.nodeType is 1
              v.push
                event: "start"
                offset: z
                node: A

              z = w(A, z)
              v.push
                event: "stop"
                offset: z
                node: A

        A = A.nextSibling
      z
    ) x, 0
    v
  q = (w, y, C) ->
    B = ->
      return (if w.length then w else y)  if not w.length or not y.length
      return (if (w[0].offset < y[0].offset) then w else y)  unless w[0].offset is y[0].offset
      (if y[0].event is "start" then w else y)
    A = (H) ->
      G = (I) ->
        " " + I.nodeName + "=\"" + k(I.value) + "\""
      F += "<" + t(H) + Array::map.call(H.attributes, G).join("") + ">"
      return
    E = (G) ->
      F += "</" + t(G) + ">"
      return
    v = (G) ->
      ((if G.event is "start" then A else E)) G.node
      return
    x = 0
    F = ""
    z = []
    while w.length or y.length
      D = B()
      F += k(C.substr(x, D[0].offset - x))
      x = D[0].offset
      if D is w
        z.reverse().forEach E
        loop
          v D.splice(0, 1)[0]
          D = B()
          break unless D is w and D.length and D[0].offset is x
        z.reverse().forEach A
      else
        if D[0].event is "start"
          z.push D[0].node
        else
          z.pop()
        v D.splice(0, 1)[0]
    F + k(C.substr(x))
  m = (y) ->
    v = (z) ->
      (z and z.source) or z
    w = (A, z) ->
      RegExp v(A), "m" + ((if y.cI then "i" else "")) + ((if z then "g" else ""))
    x = (D, C) ->
      return  if D.compiled
      D.compiled = true
      D.k = D.k or D.bK
      if D.k
        E = (G, F) ->
          F = F.toLowerCase()  if y.cI
          F.split(" ").forEach (H) ->
            I = H.split("|")
            z[I[0]] = [
              G
              (if I[1] then Number(I[1]) else 1)
            ]
            return

          return
        z = {}
        if typeof D.k is "string"
          E "keyword", D.k
        else
          Object.keys(D.k).forEach (F) ->
            E F, D.k[F]
            return

        D.k = z
      D.lR = w(D.l or /\b[A-Za-z0-9_]+\b/, true)
      if C
        D.b = D.bK.split(" ").join("|")  if D.bK
        D.b = /\B|\b/  unless D.b
        D.bR = w(D.b)
        D.e = /\B|\b/  if not D.e and not D.eW
        D.eR = w(D.e)  if D.e
        D.tE = v(D.e) or ""
        D.tE += ((if D.e then "|" else "")) + C.tE  if D.eW and C.tE
      D.iR = w(D.i)  if D.i
      D.r = 1  if D.r is `undefined`
      D.c = []  unless D.c
      B = []
      D.c.forEach (F) ->
        if F.v
          F.v.forEach (G) ->
            B.push o(F, G)
            return

        else
          B.push (if F is "self" then D else F)
        return

      D.c = B
      D.c.forEach (F) ->
        x F, D
        return

      x D.starts, C  if D.starts
      A = D.c.map((F) ->
        (if F.bK then "\\.?\\b(" + F.b + ")\\b\\.?" else F.b)
      ).concat([D.tE]).concat([D.i]).map(v).filter(Boolean)
      D.t = (if A.length then w(A.join("|"), true) else exec: (F) ->
        null
      )
      D.continuation = {}
      return
    x y
    return
  c = (S, L, J, R) ->
    v = (U, V) ->
      T = 0

      while T < V.c.length
        return V.c[T]  if i(V.c[T].bR, U)
        T++
      return
    z = (U, T) ->
      return U  if i(U.eR, T)
      z U.parent, T  if U.eW
    A = (T, U) ->
      not J and i(U.iR, T)
    E = (V, T) ->
      U = (if M.cI then T[0].toLowerCase() else T[0])
      V.k.hasOwnProperty(U) and V.k[U]
    w = (Z, X, W, V) ->
      T = (if V then "" else b.classPrefix)
      U = "<span class=\"" + T
      Y = (if W then "" else "</span>")
      U += Z + "\">"
      U + X + Y
    N = ->
      U = k(C)
      return U  unless I.k
      T = ""
      X = 0
      I.lR.lastIndex = 0
      V = I.lR.exec(U)
      while V
        T += U.substr(X, V.index - X)
        W = E(I, V)
        if W
          H += W[1]
          T += w(W[0], V[0])
        else
          T += V[0]
        X = I.lR.lastIndex
        V = I.lR.exec(U)
      T + U.substr(X)
    F = ->
      return k(C)  if I.sL and not f[I.sL]
      T = (if I.sL then c(I.sL, C, true, I.continuation.top) else g(C))
      H += T.r  if I.r > 0
      I.continuation.top = T.top  if I.subLanguageMode is "continuous"
      w T.language, T.value, false, true
    Q = ->
      (if I.sL isnt `undefined` then F() else N())
    P = (V, U) ->
      T = (if V.cN then w(V.cN, "", true) else "")
      if V.rB
        D += T
        C = ""
      else
        if V.eB
          D += k(U) + T
          C = ""
        else
          D += T
          C = U
      I = Object.create(V,
        parent:
          value: I
      )
      return
    G = (T, X) ->
      C += T
      if X is `undefined`
        D += Q()
        return 0
      V = v(X, I)
      if V
        D += Q()
        P V, X
        return (if V.rB then 0 else X.length)
      W = z(I, X)
      if W
        U = I
        C += X  unless U.rE or U.eE
        D += Q()
        loop
          D += "</span>"  if I.cN
          H += I.r
          I = I.parent
          break unless I isnt W.parent
        D += k(X)  if U.eE
        C = ""
        P W.starts, ""  if W.starts
        return (if U.rE then 0 else X.length)
      throw new Error("Illegal lexeme \"" + X + "\" for mode \"" + (I.cN or "<unnamed>") + "\"")  if A(X, I)
      C += X
      X.length or 1
    M = j(S)
    throw new Error("Unknown language: \"" + S + "\"")  unless M
    m M
    I = R or M
    D = ""
    K = I

    while K isnt M
      D = w(K.cN, D, true)  if K.cN
      K = K.parent
    C = ""
    H = 0
    try
      B = undefined
      y = undefined
      x = 0
      loop
        I.t.lastIndex = x
        B = I.t.exec(L)
        break  unless B
        y = G(L.substr(x, B.index - x), B[0])
        x = B.index + y
      G L.substr(x)
      K = I

      while K.parent
        D += "</span>"  if K.cN
        K = K.parent
      return (
        r: H
        value: D
        language: S
        top: I
      )
    catch O
      unless O.message.indexOf("Illegal") is -1
        return (
          r: 0
          value: k(L)
        )
      else
        throw O
    return
  g = (y, x) ->
    x = x or b.languages or Object.keys(f)
    v =
      r: 0
      value: k(y)

    w = v
    x.forEach (z) ->
      return  unless j(z)
      A = c(z, y, false)
      A.language = z
      w = A  if A.r > w.r
      if A.r > v.r
        w = v
        v = A
      return

    v.second_best = w  if w.language
    v
  h = (v) ->
    if b.tabReplace
      v = v.replace(/^((<[^>]+>|\t)+)/g, (w, z, y, x) ->
        z.replace /\t/g, b.tabReplace
      )
    v = v.replace(/\n/g, "<br>")  if b.useBR
    v
  p = (z) ->
    y = d(z)
    A = r(z)
    return  if A is "no-highlight"
    v = (if A then c(A, y, true) else g(y))
    w = u(z)
    if w.length
      x = document.createElementNS("http://www.w3.org/1999/xhtml", "pre")
      x.innerHTML = v.value
      v.value = q(w, u(x), y)
    v.value = h(v.value)
    z.innerHTML = v.value
    z.className += " hljs " + (not A and v.language or "")
    z.result =
      language: v.language
      re: v.r

    if v.second_best
      z.second_best =
        language: v.second_best.language
        re: v.second_best.r
    return
  s = (v) ->
    b = o(b, v)
    return
  l = ->
    return  if l.called
    l.called = true
    v = document.querySelectorAll("pre code")
    Array::forEach.call v, p
    return
  a = ->
    addEventListener "DOMContentLoaded", l, false
    addEventListener "load", l, false
    return
  e = (v, x) ->
    w = f[v] = x(this)
    if w.aliases
      w.aliases.forEach (y) ->
        n[y] = v
        return

    return
  j = (v) ->
    f[v] or f[n[v]]
  b =
    classPrefix: "hljs-"
    tabReplace: null
    useBR: false
    languages: `undefined`

  f = {}
  n = {}
  @highlight = c
  @highlightAuto = g
  @fixMarkup = h
  @highlightBlock = p
  @configure = s
  @initHighlighting = l
  @initHighlightingOnLoad = a
  @registerLanguage = e
  @getLanguage = j
  @inherit = o
  @IR = "[a-zA-Z][a-zA-Z0-9_]*"
  @UIR = "[a-zA-Z_][a-zA-Z0-9_]*"
  @NR = "\\b\\d+(\\.\\d+)?"
  @CNR = "(\\b0[xX][a-fA-F0-9]+|(\\b\\d+(\\.\\d*)?|\\.\\d+)([eE][-+]?\\d+)?)"
  @BNR = "\\b(0b[01]+)"
  @RSR = "!|!=|!==|%|%=|&|&&|&=|\\*|\\*=|\\+|\\+=|,|-|-=|/=|/|:|;|<<|<<=|<=|<|===|==|=|>>>=|>>=|>=|>>>|>>|>|\\?|\\[|\\{|\\(|\\^|\\^=|\\||\\|=|\\|\\||~"
  @BE =
    b: "\\\\[\\s\\S]"
    r: 0

  @ASM =
    cN: "string"
    b: "'"
    e: "'"
    i: "\\n"
    c: [@BE]

  @QSM =
    cN: "string"
    b: "\""
    e: "\""
    i: "\\n"
    c: [@BE]

  @CLCM =
    cN: "comment"
    b: "//"
    e: "$"

  @CBLCLM =
    cN: "comment"
    b: "/\\*"
    e: "\\*/"

  @HCM =
    cN: "comment"
    b: "#"
    e: "$"

  @NM =
    cN: "number"
    b: @NR
    r: 0

  @CNM =
    cN: "number"
    b: @CNR
    r: 0

  @BNM =
    cN: "number"
    b: @BNR
    r: 0

  @REGEXP_MODE =
    cN: "regexp"
    b: /\//
    e: /\/[gim]*/
    i: /\n/
    c: [
      this.BE
      {
        b: /\[/
        e: /\]/
        r: 0
        c: [@BE]
      }
    ]

  @TM =
    cN: "title"
    b: @IR
    r: 0

  @UTM =
    cN: "title"
    b: @UIR
    r: 0

  return
()
hljs.registerLanguage "bash", (b) ->
  a =
    cN: "variable"
    v: [
      {
        b: /\$[\w\d#@][\w\d_]*/
      }
      {
        b: /\$\{(.*?)\}/
      }
    ]

  d =
    cN: "string"
    b: /"/
    e: /"/
    c: [
      b.BE
      a
      {
        cN: "variable"
        b: /\$\(/
        e: /\)/
        c: [b.BE]
      }
    ]

  c =
    cN: "string"
    b: /'/
    e: /'/

  l: /-?[a-z\.]+/
  k:
    keyword: "if then else elif fi for break continue while in do done exit return set declare case esac export exec"
    literal: "true false"
    built_in: "printf echo read cd pwd pushd popd dirs let eval unset typeset readonly getopts source shopt caller type hash bind help sudo"
    operator: "-ne -eq -lt -gt -f -d -e -s -l -a"

  c: [
    {
      cN: "shebang"
      b: /^#![^\n]+sh\s*$/
      r: 10
    }
    {
      cN: "function"
      b: /\w[\w\d_]*\s*\(\s*\)\s*\{/
      rB: true
      c: [b.inherit(b.TM,
        b: /\w[\w\d_]*/
      )]
      r: 0
    }
    b.HCM
    b.NM
    d
    c
    a
  ]

hljs.registerLanguage "ruby", (e) ->
  h = "[a-zA-Z_]\\w*[!?=]?|[-+~]\\@|<<|>>|=~|===?|<=>|[<>]=?|\\*\\*|[-/+%^&*~`|]|\\[\\]=?"
  g = "and false then defined module in return redo if BEGIN retry end for true self when next until do begin unless END rescue nil else break undef not super class case require yield alias while ensure elsif or include attr_reader attr_writer attr_accessor"
  a =
    cN: "yardoctag"
    b: "@[A-Za-z]+"

  i =
    cN: "comment"
    v: [
      {
        b: "#"
        e: "$"
        c: [a]
      }
      {
        b: "^\\=begin"
        e: "^\\=end"
        c: [a]
        r: 10
      }
      {
        b: "^__END__"
        e: "\\n$"
      }
    ]

  c =
    cN: "subst"
    b: "#\\{"
    e: "}"
    k: g

  d =
    cN: "string"
    c: [
      e.BE
      c
    ]
    v: [
      {
        b: /'/
        e: /'/
      }
      {
        b: /"/
        e: /"/
      }
      {
        b: "%[qw]?\\("
        e: "\\)"
      }
      {
        b: "%[qw]?\\["
        e: "\\]"
      }
      {
        b: "%[qw]?{"
        e: "}"
      }
      {
        b: "%[qw]?<"
        e: ">"
        r: 10
      }
      {
        b: "%[qw]?/"
        e: "/"
        r: 10
      }
      {
        b: "%[qw]?%"
        e: "%"
        r: 10
      }
      {
        b: "%[qw]?-"
        e: "-"
        r: 10
      }
      {
        b: "%[qw]?\\|"
        e: "\\|"
        r: 10
      }
      {
        b: /\B\?(\\\d{1,3}|\\x[A-Fa-f0-9]{1,2}|\\u[A-Fa-f0-9]{4}|\\?\S)\b/
      }
    ]

  b =
    cN: "params"
    b: "\\("
    e: "\\)"
    k: g

  f = [
    d
    i
    {
      cN: "class"
      bK: "class module"
      e: "$|;"
      i: RegExp("=")
      c: [
        e.inherit(e.TM,
          b: "[A-Za-z_]\\w*(::\\w+)*(\\?|\\!)?"
        )
        {
          cN: "inheritance"
          b: "<\\s*"
          c: [
            cN: "parent"
            b: "(" + e.IR + "::)?" + e.IR
          ]
        }
        i
      ]
    }
    {
      cN: "function"
      bK: "def"
      e: " |$|;"
      r: 0
      c: [
        e.inherit(e.TM,
          b: h
        )
        b
        i
      ]
    }
    {
      cN: "constant"
      b: "(::)?(\\b[A-Z]\\w*(::)?)+"
      r: 0
    }
    {
      cN: "symbol"
      b: ":"
      c: [
        d
        {
          b: h
        }
      ]
      r: 0
    }
    {
      cN: "symbol"
      b: e.UIR + "(\\!|\\?)?:"
      r: 0
    }
    {
      cN: "number"
      b: "(\\b0[0-7_]+)|(\\b0x[0-9a-fA-F_]+)|(\\b[1-9][0-9_]*(\\.[0-9_]+)?)|[0_]\\b"
      r: 0
    }
    {
      cN: "variable"
      b: "(\\$\\W)|((\\$|\\@\\@?)(\\w+))"
    }
    {
      b: "(" + e.RSR + ")\\s*"
      c: [
        i
        {
          cN: "regexp"
          c: [
            e.BE
            c
          ]
          i: /\n/
          v: [
            {
              b: "/"
              e: "/[a-z]*"
            }
            {
              b: "%r{"
              e: "}[a-z]*"
            }
            {
              b: "%r\\("
              e: "\\)[a-z]*"
            }
            {
              b: "%r!"
              e: "![a-z]*"
            }
            {
              b: "%r\\["
              e: "\\][a-z]*"
            }
          ]
        }
      ]
      r: 0
    }
  ]
  c.c = f
  b.c = f
  k: g
  c: f

hljs.registerLanguage "javascript", (a) ->
  aliases: ["js"]
  k:
    keyword: "in if for while finally var new function do return void else break catch instanceof with throw case default try this switch continue typeof delete let yield const class"
    literal: "true false null undefined NaN Infinity"
    built_in: "eval isFinite isNaN parseFloat parseInt decodeURI decodeURIComponent encodeURI encodeURIComponent escape unescape Object Function Boolean Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError Number Math Date String RegExp Array Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint32Array Uint8Array Uint8ClampedArray ArrayBuffer DataView JSON Intl arguments require"

  c: [
    {
      cN: "pi"
      b: /^\s*('|")use strict('|")/
      r: 10
    }
    a.ASM
    a.QSM
    a.CLCM
    a.CBLCLM
    a.CNM
    {
      b: "(" + a.RSR + "|\\b(case|return|throw)\\b)\\s*"
      k: "return throw case"
      c: [
        a.CLCM
        a.CBLCLM
        a.REGEXP_MODE
        {
          b: /</
          e: />;/
          r: 0
          sL: "xml"
        }
      ]
      r: 0
    }
    {
      cN: "function"
      bK: "function"
      e: /\{/
      c: [
        a.inherit(a.TM,
          b: /[A-Za-z$_][0-9A-Za-z$_]*/
        )
        {
          cN: "params"
          b: /\(/
          e: /\)/
          c: [
            a.CLCM
            a.CBLCLM
          ]
          i: /["'\(]/
        }
      ]
      i: /\[|%/
    }
    {
      b: /\$[(.]/
    }
    {
      b: "\\." + a.IR
      r: 0
    }
  ]

hljs.registerLanguage "xml", (a) ->
  c = "[A-Za-z0-9\\._:-]+"
  d =
    b: /<\?(php)?(?!\w)/
    e: /\?>/
    sL: "php"
    subLanguageMode: "continuous"

  b =
    eW: true
    i: /</
    r: 0
    c: [
      d
      {
        cN: "attribute"
        b: c
        r: 0
      }
      {
        b: "="
        r: 0
        c: [
          cN: "value"
          v: [
            {
              b: /"/
              e: /"/
            }
            {
              b: /'/
              e: /'/
            }
            {
              b: /[^\s\/>]+/
            }
          ]
        ]
      }
    ]

  aliases: ["html"]
  cI: true
  c: [
    {
      cN: "doctype"
      b: "<!DOCTYPE"
      e: ">"
      r: 10
      c: [
        b: "\\["
        e: "\\]"
      ]
    }
    {
      cN: "comment"
      b: "<!--"
      e: "-->"
      r: 10
    }
    {
      cN: "cdata"
      b: "<\\!\\[CDATA\\["
      e: "\\]\\]>"
      r: 10
    }
    {
      cN: "tag"
      b: "<style(?=\\s|>|$)"
      e: ">"
      k:
        title: "style"

      c: [b]
      starts:
        e: "</style>"
        rE: true
        sL: "css"
    }
    {
      cN: "tag"
      b: "<script(?=\\s|>|$)"
      e: ">"
      k:
        title: "script"

      c: [b]
      starts:
        e: "</script>"
        rE: true
        sL: "javascript"
    }
    {
      b: "<%"
      e: "%>"
      sL: "vbscript"
    }
    d
    {
      cN: "pi"
      b: /<\?\w+/
      e: /\?>/
      r: 10
    }
    {
      cN: "tag"
      b: "</?"
      e: "/?>"
      c: [
        {
          cN: "title"
          b: "[^ /><]+"
          r: 0
        }
        b
      ]
    }
  ]

hljs.registerLanguage "markdown", (a) ->
  c: [
    {
      cN: "header"
      v: [
        {
          b: '^#{1,6}'
          e: "$"
        }
        {
          b: "^.+?\\n[=-]{2,}$"
        }
      ]
    }
    {
      b: "<"
      e: ">"
      sL: "xml"
      r: 0
    }
    {
      cN: "bullet"
      b: "^([*+-]|(\\d+\\.))\\s+"
    }
    {
      cN: "strong"
      b: "[*_]{2}.+?[*_]{2}"
    }
    {
      cN: "emphasis"
      v: [
        {
          b: "\\*.+?\\*"
        }
        {
          b: "_.+?_"
          r: 0
        }
      ]
    }
    {
      cN: "blockquote"
      b: "^>\\s+"
      e: "$"
    }
    {
      cN: "code"
      v: [
        {
          b: "`.+?`"
        }
        {
          b: "^( {4}|\t)"
          e: "$"
          r: 0
        }
      ]
    }
    {
      cN: "horizontal_rule"
      b: "^[-\\*]{3,}"
      e: "$"
    }
    {
      b: "\\[.+?\\][\\(\\[].+?[\\)\\]]"
      rB: true
      c: [
        {
          cN: "link_label"
          b: "\\["
          e: "\\]"
          eB: true
          rE: true
          r: 0
        }
        {
          cN: "link_url"
          b: "\\]\\("
          e: "\\)"
          eB: true
          eE: true
        }
        {
          cN: "link_reference"
          b: "\\]\\["
          e: "\\]"
          eB: true
          eE: true
        }
      ]
      r: 10
    }
    {
      b: "^\\[.+\\]:"
      e: "$"
      rB: true
      c: [
        {
          cN: "link_reference"
          b: "\\["
          e: "\\]"
          eB: true
          eE: true
        }
        {
          cN: "link_url"
          b: "\\s"
          e: "$"
        }
      ]
    }
  ]

hljs.registerLanguage "css", (a) ->
  b = "[a-zA-Z-][a-zA-Z0-9_-]*"
  c =
    cN: "function"
    b: b + "\\("
    e: "\\)"
    c: [
      "self"
      a.NM
      a.ASM
      a.QSM
    ]

  cI: true
  i: "[=/|']"
  c: [
    a.CBLCLM
    {
      cN: "id"
      b: "\\#[A-Za-z0-9_-]+"
    }
    {
      cN: "class"
      b: "\\.[A-Za-z0-9_-]+"
      r: 0
    }
    {
      cN: "attr_selector"
      b: "\\["
      e: "\\]"
      i: "$"
    }
    {
      cN: "pseudo"
      b: ":(:)?[a-zA-Z0-9\\_\\-\\+\\(\\)\\\"\\']+"
    }
    {
      cN: "at_rule"
      b: "@(font-face|page)"
      l: "[a-z-]+"
      k: "font-face page"
    }
    {
      cN: "at_rule"
      b: "@"
      e: "[{;]"
      c: [
        {
          cN: "keyword"
          b: /\S+/
        }
        {
          b: /\s/
          eW: true
          eE: true
          r: 0
          c: [
            c
            a.ASM
            a.QSM
            a.NM
          ]
        }
      ]
    }
    {
      cN: "tag"
      b: b
      r: 0
    }
    {
      cN: "rules"
      b: "{"
      e: "}"
      i: "[^\\s]"
      r: 0
      c: [
        a.CBLCLM
        {
          cN: "rule"
          b: "[^\\s]"
          rB: true
          e: ";"
          eW: true
          c: [
            cN: "attribute"
            b: "[A-Z\\_\\.\\-]+"
            e: ":"
            eE: true
            i: "[^\\s]"
            starts:
              cN: "value"
              eW: true
              eE: true
              c: [
                c
                a.NM
                a.QSM
                a.ASM
                a.CBLCLM
                {
                  cN: "hexcolor"
                  b: "#[0-9A-Fa-f]+"
                }
                {
                  cN: "important"
                  b: "!important"
                }
              ]
          ]
        }
      ]
    }
  ]

hljs.registerLanguage "http", (a) ->
  i: "\\S"
  c: [
    {
      cN: "status"
      b: "^HTTP/[0-9\\.]+"
      e: "$"
      c: [
        cN: "number"
        b: "\\b\\d{3}\\b"
      ]
    }
    {
      cN: "request"
      b: "^[A-Z]+ (.*?) HTTP/[0-9\\.]+$"
      rB: true
      e: "$"
      c: [
        cN: "string"
        b: " "
        e: " "
        eB: true
        eE: true
      ]
    }
    {
      cN: "attribute"
      b: "^\\w"
      e: ": "
      eE: true
      i: "\\n|\\s|="
      starts:
        cN: "string"
        e: "$"
    }
    {
      b: "\\n\\n"
      starts:
        sL: ""
        eW: true
    }
  ]

hljs.registerLanguage "php", (b) ->
  e =
    cN: "variable"
    b: "\\$+[a-zA-Z_-ÿ][a-zA-Z0-9_-ÿ]*"

  a =
    cN: "preprocessor"
    b: /<\?(php)?|\?>/

  c =
    cN: "string"
    c: [
      b.BE
      a
    ]
    v: [
      {
        b: "b\""
        e: "\""
      }
      {
        b: "b'"
        e: "'"
      }
      b.inherit(b.ASM,
        i: null
      )
      b.inherit(b.QSM,
        i: null
      )
    ]

  d = v: [
    b.BNM
    b.CNM
  ]
  cI: true
  k: "and include_once list abstract global private echo interface as static endswitch array null if endwhile or const for endforeach self var while isset public protected exit foreach throw elseif include __FILE__ empty require_once do xor return parent clone use __CLASS__ __LINE__ else break print eval new catch __METHOD__ case exception default die require __FUNCTION__ enddeclare final try switch continue endfor endif declare unset true false trait goto instanceof insteadof __DIR__ __NAMESPACE__ yield finally"
  c: [
    b.CLCM
    b.HCM
    {
      cN: "comment"
      b: "/\\*"
      e: "\\*/"
      c: [
        {
          cN: "phpdoc"
          b: "\\s@[A-Za-z]+"
        }
        a
      ]
    }
    {
      cN: "comment"
      b: "__halt_compiler.+?;"
      eW: true
      k: "__halt_compiler"
      l: b.UIR
    }
    {
      cN: "string"
      b: "<<<['\"]?\\w+['\"]?$"
      e: "^\\w+;"
      c: [b.BE]
    }
    a
    e
    {
      cN: "function"
      bK: "function"
      e: /[;{]/
      i: "\\$|\\[|%"
      c: [
        b.UTM
        {
          cN: "params"
          b: "\\("
          e: "\\)"
          c: [
            "self"
            e
            b.CBLCLM
            c
            d
          ]
        }
      ]
    }
    {
      cN: "class"
      bK: "class interface"
      e: "{"
      i: /[:\(\$"]/
      c: [
        {
          bK: "extends implements"
          r: 10
        }
        b.UTM
      ]
    }
    {
      bK: "namespace"
      e: ";"
      i: /[\.']/
      c: [b.UTM]
    }
    {
      bK: "use"
      e: ";"
      c: [b.UTM]
    }
    {
      b: "=>"
    }
    c
    d
  ]

hljs.registerLanguage "python", (a) ->
  f =
    cN: "prompt"
    b: /^(>>>|\.\.\.) /

  b =
    cN: "string"
    c: [a.BE]
    v: [
      {
        b: /(u|b)?r?'''/
        e: /'''/
        c: [f]
        r: 10
      }
      {
        b: /(u|b)?r?"""/
        e: /"""/
        c: [f]
        r: 10
      }
      {
        b: /(u|r|ur)'/
        e: /'/
        r: 10
      }
      {
        b: /(u|r|ur)"/
        e: /"/
        r: 10
      }
      {
        b: /(b|br)'/
        e: /'/
      }
      {
        b: /(b|br)"/
        e: /"/
      }
      a.ASM
      a.QSM
    ]

  d =
    cN: "number"
    r: 0
    v: [
      {
        b: a.BNR + "[lLjJ]?"
      }
      {
        b: "\\b(0o[0-7]+)[lLjJ]?"
      }
      {
        b: a.CNR + "[lLjJ]?"
      }
    ]

  e =
    cN: "params"
    b: /\(/
    e: /\)/
    c: [
      "self"
      f
      d
      b
    ]

  c =
    e: /:/
    i: /[${=;\n]/
    c: [
      a.UTM
      e
    ]

  k:
    keyword: "and elif is global as in if from raise for except finally print import pass return exec else break not with class assert yield try while continue del or def lambda nonlocal|10 None True False"
    built_in: "Ellipsis NotImplemented"

  i: /(<\/|->|\?)/
  c: [
    f
    d
    b
    a.HCM
    a.inherit(c,
      cN: "function"
      bK: "def"
      r: 10
    )
    a.inherit(c,
      cN: "class"
      bK: "class"
    )
    {
      cN: "decorator"
      b: /@/
      e: /$/
    }
    {
      b: /\b(print|exec)\(/
    }
  ]

hljs.registerLanguage "sql", (a) ->
  cI: true
  i: /[<>]/
  c: [
    {
      cN: "operator"
      b: "\\b(begin|end|start|commit|rollback|savepoint|lock|alter|create|drop|rename|call|delete|do|handler|insert|load|replace|select|truncate|update|set|show|pragma|grant|merge)\\b(?!:)"
      e: ";"
      eW: true
      k:
        keyword: "all partial global month current_timestamp using go revoke smallint indicator end-exec disconnect zone with character assertion to add current_user usage input local alter match collate real then rollback get read timestamp session_user not integer bit unique day minute desc insert execute like ilike|2 level decimal drop continue isolation found where constraints domain right national some module transaction relative second connect escape close system_user for deferred section cast current sqlstate allocate intersect deallocate numeric public preserve full goto initially asc no key output collation group by union session both last language constraint column of space foreign deferrable prior connection unknown action commit view or first into float year primary cascaded except restrict set references names table outer open select size are rows from prepare distinct leading create only next inner authorization schema corresponding option declare precision immediate else timezone_minute external varying translation true case exception join hour default double scroll value cursor descriptor values dec fetch procedure delete and false int is describe char as at in varchar null trailing any absolute current_time end grant privileges when cross check write current_date pad begin temporary exec time update catalog user sql date on identity timezone_hour natural whenever interval work order cascade diagnostics nchar having left call do handler load replace truncate start lock show pragma exists number trigger if before after each row merge matched database"
        aggregate: "count sum min max avg"

      c: [
        {
          cN: "string"
          b: "'"
          e: "'"
          c: [
            a.BE
            {
              b: "''"
            }
          ]
        }
        {
          cN: "string"
          b: "\""
          e: "\""
          c: [
            a.BE
            {
              b: "\"\""
            }
          ]
        }
        {
          cN: "string"
          b: "`"
          e: "`"
          c: [a.BE]
        }
        a.CNM
      ]
    }
    a.CBLCLM
    {
      cN: "comment"
      b: "--"
      e: "$"
    }
  ]

hljs.registerLanguage "handlebars", (b) ->
  a = "each in with if else unless bindattr action collection debugger log outlet template unbound view yield"
  cI: true
  sL: "xml"
  subLanguageMode: "continuous"
  c: [
    cN: "expression"
    b: "{{"
    e: "}}"
    c: [
      {
        cN: "begin-block"
        b: "#[a-zA-Z- .]+"
        k: a
      }
      {
        cN: "string"
        b: "\""
        e: "\""
      }
      {
        cN: "end-block"
        b: "\\/[a-zA-Z- .]+"
        k: a
      }
      {
        cN: "variable"
        b: "[a-zA-Z-.]+"
        k: a
      }
    ]
  ]

hljs.registerLanguage "objectivec", (a) ->
  d =
    keyword: "int float while char export sizeof typedef const struct for union unsigned long volatile static bool mutable if do return goto void enum else break extern asm case short default double register explicit signed typename this switch continue wchar_t inline readonly assign self synchronized id nonatomic super unichar IBOutlet IBAction strong weak @private @protected @public @try @property @end @throw @catch @finally @synthesize @dynamic @selector @optional @required"
    literal: "false true FALSE TRUE nil YES NO NULL"
    built_in: "NSString NSDictionary CGRect CGPoint UIButton UILabel UITextView UIWebView MKMapView UISegmentedControl NSObject UITableViewDelegate UITableViewDataSource NSThread UIActivityIndicator UITabbar UIToolBar UIBarButtonItem UIImageView NSAutoreleasePool UITableView BOOL NSInteger CGFloat NSException NSLog NSMutableString NSMutableArray NSMutableDictionary NSURL NSIndexPath CGSize UITableViewCell UIView UIViewController UINavigationBar UINavigationController UITabBarController UIPopoverController UIPopoverControllerDelegate UIImage NSNumber UISearchBar NSFetchedResultsController NSFetchedResultsChangeType UIScrollView UIScrollViewDelegate UIEdgeInsets UIColor UIFont UIApplication NSNotFound NSNotificationCenter NSNotification UILocalNotification NSBundle NSFileManager NSTimeInterval NSDate NSCalendar NSUserDefaults UIWindow NSRange NSArray NSError NSURLRequest NSURLConnection UIInterfaceOrientation MPMoviePlayerController dispatch_once_t dispatch_queue_t dispatch_sync dispatch_async dispatch_once"

  c = /[a-zA-Z@][a-zA-Z0-9_]*/
  b = "@interface @class @protocol @implementation"
  k: d
  l: c
  i: "</"
  c: [
    a.CLCM
    a.CBLCLM
    a.CNM
    a.QSM
    {
      cN: "string"
      b: "'"
      e: "[^\\\\]'"
      i: "[^\\\\][^']"
    }
    {
      cN: "preprocessor"
      b: "#import"
      e: "$"
      c: [
        {
          cN: "title"
          b: "\""
          e: "\""
        }
        {
          cN: "title"
          b: "<"
          e: ">"
        }
      ]
    }
    {
      cN: "preprocessor"
      b: "#"
      e: "$"
    }
    {
      cN: "class"
      b: "(" + b.split(" ").join("|") + ")\\b"
      e: "({|$)"
      k: b
      l: c
      c: [a.UTM]
    }
    {
      cN: "variable"
      b: "\\." + a.UIR
      r: 0
    }
  ]

hljs.registerLanguage "coffeescript", (c) ->
  b =
    keyword: "in if for while finally new do return else break catch instanceof throw try this switch continue typeof delete debugger super then unless until loop of by when and or is isnt not"
    literal: "true false null undefined yes no on off"
    reserved: "case default function var void with const let enum export import native __hasProp __extends __slice __bind __indexOf"
    built_in: "npm require console print module exports global window document"

  a = "[A-Za-z$_][0-9A-Za-z$_]*"
  f = c.inherit(c.TM,
    b: a
  )
  e =
    cN: "subst"
    b: /#\{/
    e: /}/
    k: b

  d = [
    c.BNM
    c.inherit(c.CNM,
      starts:
        e: "(\\s*/)?"
        r: 0
    )
    {
      cN: "string"
      v: [
        {
          b: /'''/
          e: /'''/
          c: [c.BE]
        }
        {
          b: /'/
          e: /'/
          c: [c.BE]
        }
        {
          b: /"""/
          e: /"""/
          c: [
            c.BE
            e
          ]
        }
        {
          b: /"/
          e: /"/
          c: [
            c.BE
            e
          ]
        }
      ]
    }
    {
      cN: "regexp"
      v: [
        {
          b: "///"
          e: "///"
          c: [
            e
            c.HCM
          ]
        }
        {
          b: "//[gim]*"
          r: 0
        }
        {
          b: "/\\S(\\\\.|[^\\n])*?/[gim]*(?=\\s|\\W|$)"
        }
      ]
    }
    {
      cN: "property"
      b: "@" + a
    }
    {
      b: "`"
      e: "`"
      eB: true
      eE: true
      sL: "javascript"
    }
  ]
  e.c = d
  k: b
  c: d.concat([
    {
      cN: "comment"
      b: "###"
      e: "###"
    }
    c.HCM
    {
      cN: "function"
      b: "(" + a + "\\s*=\\s*)?(\\(.*\\))?\\s*\\B[-=]>"
      e: "[-=]>"
      rB: true
      c: [
        f
        {
          cN: "params"
          b: "\\("
          rB: true
          c: [
            b: /\(/
            e: /\)/
            k: b
            c: ["self"].concat(d)
          ]
        }
      ]
    }
    {
      cN: "class"
      bK: "class"
      e: "$"
      i: /[:="\[\]]/
      c: [
        {
          bK: "extends"
          eW: true
          i: /[:="\[\]]/
          c: [f]
        }
        f
      ]
    }
    {
      cN: "attribute"
      b: a + ":"
      e: ":"
      rB: true
      eE: true
      r: 0
    }
  ])

hljs.registerLanguage "nginx", (c) ->
  b =
    cN: "variable"
    v: [
      {
        b: /\$\d+/
      }
      {
        b: /\$\{/
        e: /}/
      }
      {
        b: "[\\$\\@]" + c.UIR
      }
    ]

  a =
    eW: true
    l: "[a-z/_]+"
    k:
      built_in: "on off yes no true false none blocked debug info notice warn error crit select break last permanent redirect kqueue rtsig epoll poll /dev/poll"

    r: 0
    i: "=>"
    c: [
      c.HCM
      {
        cN: "string"
        c: [
          c.BE
          b
        ]
        v: [
          {
            b: /"/
            e: /"/
          }
          {
            b: /'/
            e: /'/
          }
        ]
      }
      {
        cN: "url"
        b: "([a-z]+):/"
        e: "\\s"
        eW: true
        eE: true
      }
      {
        cN: "regexp"
        c: [
          c.BE
          b
        ]
        v: [
          {
            b: "\\s\\^"
            e: "\\s|{|;"
            rE: true
          }
          {
            b: "~\\*?\\s+"
            e: "\\s|{|;"
            rE: true
          }
          {
            b: "\\*(\\.[a-z\\-]+)+"
          }
          {
            b: "([a-z\\-]+\\.)+\\*"
          }
        ]
      }
      {
        cN: "number"
        b: "\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}(:\\d{1,5})?\\b"
      }
      {
        cN: "number"
        b: "\\b\\d+[kKmMgGdshdwy]*\\b"
        r: 0
      }
      b
    ]

  c: [
    c.HCM
    {
      b: c.UIR + "\\s"
      e: ";|{"
      rB: true
      c: [c.inherit(c.UTM,
        starts: a
      )]
      r: 0
    }
  ]
  i: "[^\\s\\}]"

hljs.registerLanguage "json", (a) ->
  e = literal: "true false null"
  d = [
    a.QSM
    a.CNM
  ]
  c =
    cN: "value"
    e: ","
    eW: true
    eE: true
    c: d
    k: e

  b =
    b: "{"
    e: "}"
    c: [
      cN: "attribute"
      b: "\\s*\""
      e: "\"\\s*:\\s*"
      eB: true
      eE: true
      c: [a.BE]
      i: "\\n"
      starts: c
    ]
    i: "\\S"

  f =
    b: "\\["
    e: "\\]"
    c: [a.inherit(c,
      cN: null
    )]
    i: "\\S"

  d.splice d.length, 0, b, f
  c: d
  k: e
  i: "\\S"

hljs.registerLanguage "scss", (a) ->
  c = "[a-zA-Z-][a-zA-Z0-9_-]*"
  d =
    cN: "function"
    b: c + "\\("
    e: "\\)"
    c: [
      "self"
      a.NM
      a.ASM
      a.QSM
    ]

  b =
    cN: "hexcolor"
    b: "#[0-9A-Fa-f]+"

  e =
    cN: "attribute"
    b: "[A-Z\\_\\.\\-]+"
    e: ":"
    eE: true
    i: "[^\\s]"
    starts:
      cN: "value"
      eW: true
      eE: true
      c: [
        d
        b
        a.NM
        a.QSM
        a.ASM
        a.CBLCLM
        {
          cN: "important"
          b: "!important"
        }
      ]

  cI: true
  i: "[=/|']"
  c: [
    a.CLCM
    a.CBLCLM
    {
      cN: "function"
      b: c + "\\("
      e: "\\)"
      c: [
        "self"
        a.NM
        a.ASM
        a.QSM
      ]
    }
    {
      cN: "id"
      b: "\\#[A-Za-z0-9_-]+"
      r: 0
    }
    {
      cN: "class"
      b: "\\.[A-Za-z0-9_-]+"
      r: 0
    }
    {
      cN: "attr_selector"
      b: "\\["
      e: "\\]"
      i: "$"
    }
    {
      cN: "tag"
      b: "\\b(a|abbr|acronym|address|area|article|aside|audio|b|base|big|blockquote|body|br|button|canvas|caption|cite|code|col|colgroup|command|datalist|dd|del|details|dfn|div|dl|dt|em|embed|fieldset|figcaption|figure|footer|form|frame|frameset|(h[1-6])|head|header|hgroup|hr|html|i|iframe|img|input|ins|kbd|keygen|label|legend|li|link|map|mark|meta|meter|nav|noframes|noscript|object|ol|optgroup|option|output|p|param|pre|progress|q|rp|rt|ruby|samp|script|section|select|small|span|strike|strong|style|sub|sup|table|tbody|td|textarea|tfoot|th|thead|time|title|tr|tt|ul|var|video)\\b"
      r: 0
    }
    {
      cN: "pseudo"
      b: ":(visited|valid|root|right|required|read-write|read-only|out-range|optional|only-of-type|only-child|nth-of-type|nth-last-of-type|nth-last-child|nth-child|not|link|left|last-of-type|last-child|lang|invalid|indeterminate|in-range|hover|focus|first-of-type|first-line|first-letter|first-child|first|enabled|empty|disabled|default|checked|before|after|active)"
    }
    {
      cN: "pseudo"
      b: "::(after|before|choices|first-letter|first-line|repeat-index|repeat-item|selection|value)"
    }
    {
      cN: "attribute"
      b: "\\b(z-index|word-wrap|word-spacing|word-break|width|widows|white-space|visibility|vertical-align|unicode-bidi|transition-timing-function|transition-property|transition-duration|transition-delay|transition|transform-style|transform-origin|transform|top|text-underline-position|text-transform|text-shadow|text-rendering|text-overflow|text-indent|text-decoration-style|text-decoration-line|text-decoration-color|text-decoration|text-align-last|text-align|tab-size|table-layout|right|resize|quotes|position|pointer-events|perspective-origin|perspective|page-break-inside|page-break-before|page-break-after|padding-top|padding-right|padding-left|padding-bottom|padding|overflow-y|overflow-x|overflow-wrap|overflow|outline-width|outline-style|outline-offset|outline-color|outline|orphans|order|opacity|object-position|object-fit|normal|none|nav-up|nav-right|nav-left|nav-index|nav-down|min-width|min-height|max-width|max-height|mask|marks|margin-top|margin-right|margin-left|margin-bottom|margin|list-style-type|list-style-position|list-style-image|list-style|line-height|letter-spacing|left|justify-content|initial|inherit|ime-mode|image-orientation|image-resolution|image-rendering|icon|hyphens|height|font-weight|font-variant-ligatures|font-variant|font-style|font-stretch|font-size-adjust|font-size|font-language-override|font-kerning|font-feature-settings|font-family|font|float|flex-wrap|flex-shrink|flex-grow|flex-flow|flex-direction|flex-basis|flex|filter|empty-cells|display|direction|cursor|counter-reset|counter-increment|content|column-width|column-span|column-rule-width|column-rule-style|column-rule-color|column-rule|column-gap|column-fill|column-count|columns|color|clip-path|clip|clear|caption-side|break-inside|break-before|break-after|box-sizing|box-shadow|box-decoration-break|bottom|border-width|border-top-width|border-top-style|border-top-right-radius|border-top-left-radius|border-top-color|border-top|border-style|border-spacing|border-right-width|border-right-style|border-right-color|border-right|border-radius|border-left-width|border-left-style|border-left-color|border-left|border-image-width|border-image-source|border-image-slice|border-image-repeat|border-image-outset|border-image|border-color|border-collapse|border-bottom-width|border-bottom-style|border-bottom-right-radius|border-bottom-left-radius|border-bottom-color|border-bottom|border|background-size|background-repeat|background-position|background-origin|background-image|background-color|background-clip|background-attachment|background|backface-visibility|auto|animation-timing-function|animation-play-state|animation-name|animation-iteration-count|animation-fill-mode|animation-duration|animation-direction|animation-delay|animation|align-self|align-items|align-content)\\b"
      i: "[^\\s]"
    }
    {
      cN: "value"
      b: "\\b(whitespace|wait|w-resize|visible|vertical-text|vertical-ideographic|uppercase|upper-roman|upper-alpha|underline|transparent|top|thin|thick|text|text-top|text-bottom|tb-rl|table-header-group|table-footer-group|sw-resize|super|strict|static|square|solid|small-caps|separate|se-resize|scroll|s-resize|rtl|row-resize|ridge|right|repeat|repeat-y|repeat-x|relative|progress|pointer|overline|outside|outset|oblique|nowrap|not-allowed|normal|none|nw-resize|no-repeat|no-drop|newspaper|ne-resize|n-resize|move|middle|medium|ltr|lr-tb|lowercase|lower-roman|lower-alpha|loose|list-item|line|line-through|line-edge|lighter|left|keep-all|justify|italic|inter-word|inter-ideograph|inside|inset|inline|inline-block|inherit|inactive|ideograph-space|ideograph-parenthesis|ideograph-numeric|ideograph-alpha|horizontal|hidden|help|hand|groove|fixed|ellipsis|e-resize|double|dotted|distribute|distribute-space|distribute-letter|distribute-all-lines|disc|disabled|default|decimal|dashed|crosshair|collapse|col-resize|circle|char|center|capitalize|break-word|break-all|bottom|both|bolder|bold|block|bidi-override|below|baseline|auto|always|all-scroll|absolute|table|table-cell)\\b"
    }
    {
      cN: "value"
      b: ":"
      e: ";"
      c: [
        b
        a.NM
        a.QSM
        a.ASM
        {
          cN: "important"
          b: "!important"
        }
      ]
    }
    {
      cN: "at_rule"
      b: "@"
      e: "[{;]"
      k: "mixin include extend for if else each while charset import debug media page content font-face namespace warn"
      c: [
        d
        a.QSM
        a.ASM
        b
        a.NM
        {
          cN: "preprocessor"
          b: "\\s[A-Za-z0-9_.-]+"
          r: 0
        }
      ]
    }
  ]

hljs.registerLanguage "makefile", (a) ->
  b =
    cN: "variable"
    b: /\$\(/
    e: /\)/
    c: [a.BE]

  c: [
    a.HCM
    {
      b: /^\w+\s*\W*=/
      rB: true
      r: 0
      starts:
        cN: "constant"
        e: /\s*\W*=/
        eE: true
        starts:
          e: /$/
          r: 0
          c: [b]
    }
    {
      cN: "title"
      b: /^[\w]+:\s*$/
    }
    {
      cN: "phony"
      b: /^\.PHONY:/
      e: /$/
      k: ".PHONY"
      l: /[\.\w]+/
    }
    {
      b: /^\t+/
      e: /$/
      c: [
        a.QSM
        b
      ]
    }
  ]
