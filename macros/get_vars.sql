-- macros/vars.sql
{% macro get_vars() %}
    {% set vars = {
        
            'initial_cols': [
                "id", "title", "tour_code", "additional_info", "amount_saved",
                "badges", "description", "brief_description", "price_currency",
                "comparison_price", "destination_id", "destination_canonical_name",
                "destination_name", "duration", "exclusions", "free_cancellation",
                "inclusions", "is_supplier_a_business", "itinerary", "offered_languages",
                "photo_urls", "price_amount", "price_varies_by_group_size",
                "price_with_extra_charges_amount", "pricing_type", "exact_rating",
                "review_count", "scraped_at", "supplier_name", "supplier_rating",
                "supplier_review_count", "url", "price_with_fees", 
            ],
        
            'egypt_keywords': [
                'egypt',
                'abydos', 'ain sokhna', 'al-qalyubia governorate', 'alexandria','sharm',
                'alexandria governorate', 'aswan', 'aswan governorate', 'badrshein',
                'bedouin village', 'beheira governorate', 'cairo', 'dahab',
                'el gouna', 'el minya', 'el-alamein', 'faiyum governorate', 'fayoum',
                'giza', 'giza (governorate)', 'hurghada', 'luxor',
                'luxor governorate', 'makadi bay', 'marsa alam', 'matrouh governorate',
                'new alamein city', 'new valley governorate', 'port ghalib', 'port safaga',
                'port said', 'qena', 'quseer', 'red sea', 'red sea governorate',
                'sharm el sheikh', 'sharm el-sheikh', 'siwa oasis', 'south sinai', 
                'suez governorate', 'tanis', 'wadi el natron monastery','alamein','qalyubia'
            ],
            'date_cols': ["scraped_at", ],
            'numeric_cols': [
                "snapshot_id", "destination_id", "exact_rating", "review_count",
                "supplier_rating", "supplier_review_count", "price_amount",
                "comparison_price", "amount_saved", "price_with_extra_charges_amount",
                "price_with_fees"
            ],
            'text_cols': [
                "tour_code","title", "brief_description", "destination_name",
                "pricing_type", "supplier_name", "url", "destination_canonical_name"
            ],
            'list_cols': [
                "additional_info", "badges", "duration", "exclusions",
                "inclusions", "itinerary", "offered_languages"
            ],
            'boolean_cols':["price_varies_by_group_size","free_cancellation"
],
            "same_day_filling": [
            "badges",
            "amount_saved",
            "comparison_price",
            "free_cancellation"
            ],
            "filling_forward": [
                "price_varies_by_group_size",
                "price_with_fees",
                "price_amount",
                "price_with_extra_charges_amount",
                "exact_rating",
                "review_count",
                "supplier_rating",
                "supplier_review_count",
                "amount_saved"
            ],
            "filling_all_directions": [
                "offered_languages",
                "additional_info",
                "duration",
                "exclusions",
                "inclusions",
                "is_supplier_a_business",
                "itinerary",
                "duration",
                "destination_name",
                "brief_description",
                "brief_description",
                "title"
            ]
    } %}
    {{ return(vars) }}
{% endmacro %}