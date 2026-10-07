{% macro nullify_values(col) %}
    CASE
        WHEN LOWER(TRIM({{ col }} ::text )) IN (
            'null',
            'none',
            '',
            '0',
            '[]',
            '{}',
            'n/a',
            'undefined'
        )
        THEN NULL

        ELSE {{ col }}
    END
{% endmacro %}


{% macro strip_html_tags(col) %}
    regexp_replace({{ col }}, '<[^>]+>', ' ', 'g')
{% endmacro %}

{% macro collapse_whitespace(col) %}
    regexp_replace({{ col }}, '[[:space:]]+', ' ', 'g')
{% endmacro %}

{% macro trim_inner_open_brackets(col) %}
    regexp_replace({{ col }}, E'(\\(|\\[|\\{)[[:space:]]+', E'\\1', 'g')
{% endmacro %}

{% macro trim_inner_close_brackets(col) %}
    regexp_replace({{ col }}, E'[[:space:]]+(\\)|\\]|\\})', E'\\1', 'g')
{% endmacro %}



{% macro clean_text(col) %}
    {%- set cleaned -%}{{ strip_html_tags(col) }}{%- endset -%}
    {%- set cleaned -%}{{ trim_inner_close_brackets(cleaned) }}{%- endset -%}
    {%- set cleaned -%}{{ trim_inner_open_brackets(cleaned) }}{%- endset -%}
    {%- set cleaned -%}{{ collapse_whitespace(cleaned) }}{%- endset -%}
    {%- set cleaned -%}{{ nullify_values(cleaned) }}{%- endset -%}

    CASE 
        WHEN {{ col }} IS NULL THEN NULL
        ELSE {{ cleaned }}
    END
{% endmacro %}

    



