{{ config(materialized='view',tags=['intermediate', 'filtration']) }}

{% set filter_vars = get_vars() %}

with tour_code_filtration as (

    select *
    from {{ ref("stg_reading_full") }}
    where tour_code is not null
),
currency_filtration as (

    select *
    from tour_code_filtration
    where price_currency = 'USD'
),destination_filtration as (

    select *
    from currency_filtration
    where trim(lower(destination_name)) in (
        {%- for word in filter_vars['egypt_keywords'] -%}
        '{{ word |lower | trim }}'{%- if not loop.last %}, {% endif -%}
        {%- endfor -%}
    )
    or trim(lower(destination_canonical_name)) in (
        {%- for word in filter_vars['egypt_keywords'] -%}
        '{{  word | lower | trim }}'{%- if not loop.last %}, {% endif -%}
        {%- endfor -%}
    )
),title_filtration as (
    select *
    from destination_filtration
    where 
        {% for word in filter_vars['egypt_keywords'] -%}
            trim(lower(title)) like '%{{ word| trim | lower }}%'
            {%- if not loop.last %} or {% endif -%}
        {%- endfor %}
)

select *
from title_filtration








