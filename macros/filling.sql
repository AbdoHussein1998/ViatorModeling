{% macro filling(
    model_name,
    filling_cols,
    partition_by,
    order_by,
    direction='forward'
) %}

    {% if direction == 'forward' %}
        {% set order_direction = 'ASC' %}
    {% elif direction == 'backward' %}
        {% set order_direction = 'DESC' %}
    {% else %}
        {{ exceptions.raise_compiler_error(
            "direction must be 'forward' or 'backward'"
        ) }}
    {% endif %}


    with windowing_cte as (

        select

            {{ dbt_utils.star(from=ref(model_name)) }}
            {% for col in filling_cols %}

                ,
                count({{ col }}) over (
                    partition by {{ partition_by }}
                    order by {{ order_by }} {{ order_direction }}
                ) as {{ col }}_grp

            {% endfor %}

        from {{ ref(model_name) }}

    ),


    filling_cte as (

        select

            {% for column in adapter.get_columns_in_relation(ref(model_name)) %}

                {% if column.name in filling_cols %}

                    first_value({{ column.name }}) over (
                        partition by
                            {{ partition_by }},
                            {{ column.name }}_grp
                        order by
                            {{ order_by }} {{ order_direction }}
                    ) as {{ column.name }}

                {% else %}

                    {{ column.name }}

                {% endif %}

                {% if not loop.last %},{% endif %}

            {% endfor %}

        from windowing_cte

    )

    select *
    from filling_cte

{% endmacro %}