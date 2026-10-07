-- stg_casting.sql
{{ config(materialized='view',tags=['staging','casting']) }}

{% set cast_vars=get_vars() %}

select
    {% for column in cast_vars["date_cols"] %}
    CAST(
        TO_CHAR(
            CAST(TRIM({{ column }}) AS timestamptz)::date,
            'YYYYMMDD'
        ) AS integer
    ) AS {% if column == 'scraped_at' %}date_key{% else %}{{ column }}{% endif %},

    {% endfor %}
    {% for column in cast_vars["date_cols"] %}
        cast(trim({{column}}) as timestamptz)  as {{column}},
    {% endfor %}

    {% for column in cast_vars["text_cols"] %}
        cast({{ column }} as text) as {{ column }},
    {% endfor %}

    {% for column in cast_vars["numeric_cols"] %}
        cast({{ column }} as numeric) as {{ column }},
    {% endfor %}

    {% for column in cast_vars["boolean_cols"]  %}
        cast({{ column }} as boolean) as {{ column }},
    {% endfor %}

    {% for column in cast_vars["list_cols"]  %}
        {{column}} {% if not loop.last %},{% endif %}
    {% endfor %}


from {{ ref("int2_cleaning") }}

where tour_code is not null


