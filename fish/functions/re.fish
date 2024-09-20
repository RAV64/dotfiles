function re
    echo """
    [abc]    - A single character of a, b or c
    [^abc]   - A character except: a, b or c
    [a-z]    - A character in the range: a-z
    [^a-z]   - A character not in the range: a-z
    [a-zA-Z] - A character in the range: a-z or A-Z
    .        - Any single character
    a|b      - Either a or b
    \\s       - Any whitespace character
    \\S       - Any non-whitespace character
    \\d       - Any digit
    \\D       - Any non-digit
    \\w       - Any word character
    \\W       - Any non-word character
    (?:...)  - Match everything enclosed
    (...)    - Capture everything enclosed
    a?       - Zero or one of a
    a*       - Zero or more of a
    a+       - One or more of a
    a{3}     - Exactly 3 of a
    a{3,}    - 3 or more of a
    a{3,6}   - Between 3 and 6 of a
    ^        - Start of string
    \$        - End of string
    \\b       - A word boundary
    \\B       - Non-word boundary
"""
end
