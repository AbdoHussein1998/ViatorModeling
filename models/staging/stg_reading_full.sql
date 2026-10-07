{{ config(materialized='view', tags=['staging','reading']) }}

{% set read_vars = get_vars() %}

with initial_reading as (

    select

    {% for column in read_vars.initial_cols %}

        {% if column | lower == 'id' %}
            {{ column }} as snapshot_id
        {% else %}
            {{ column }}
        {% endif %}

        {% if not loop.last %},{% endif %}

    {% endfor %}

    from {{ source('viator', 'tour_snapshots') }}
)

select *
from initial_reading


