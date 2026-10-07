{{ config(
    materialized="view",
    tags=["intermediate", "cleaning"]
) }}

{% set cleaning_vars = get_vars() %}

with cleaning_text as (
    select
        {{ dbt_utils.star(
            from=ref('int1_filiteration'),
            except=cleaning_vars['text_cols']
        ) }},
        {% for col in cleaning_vars['text_cols'] %}
            {{ clean_text(col) }} as {{ col }}
            {% if not loop.last %},{% endif %}
        {% endfor %}
    from {{ ref('int1_filiteration') }}
),
cleaning_numeric as (
    select
        {{ dbt_utils.star(
            from=ref('int1_filiteration'),
            except=cleaning_vars['numeric_cols']
        ) }},
        {% for col in cleaning_vars['numeric_cols'] %}
            {{ nullify_values(col) }} as {{ col }}
            {% if not loop.last %},{% endif %}
        {% endfor %}
    from cleaning_text
)

select *
from cleaning_numeric




