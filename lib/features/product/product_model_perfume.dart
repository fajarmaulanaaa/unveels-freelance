import 'dart:convert';

ProductModelPerfume productModelPerfumeFromJson(String str) => ProductModelPerfume.fromJson(json.decode(str));

String productModelPerfumeToJson(ProductModelPerfume data) => json.encode(data.toJson());

class ProductModelPerfume {
    List<Item>? items;
    SearchCriteria? searchCriteria;
    int? totalCount;

    ProductModelPerfume({
        this.items,
        this.searchCriteria,
        this.totalCount,
    });

    factory ProductModelPerfume.fromJson(Map<String, dynamic> json) => ProductModelPerfume(
        items: json["items"] != null ? List<Item>.from(json["items"].map((x) => Item.fromJson(x))) : null,
        searchCriteria: json["search_criteria"] != null ? SearchCriteria.fromJson(json["search_criteria"]) : null,
        totalCount: json["total_count"],
    );

    Map<String, dynamic> toJson() => {
        "items": items != null ? List<dynamic>.from(items!.map((x) => x.toJson())) : null,
        "search_criteria": searchCriteria?.toJson(),
        "total_count": totalCount,
    };
}

class Item {
    int? id;
    String? sku;
    String? name;
    int? attributeSetId;
    double? price;
    int? status;
    int? visibility;
    String? typeId;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? weight;
    ExtensionAttributes? extensionAttributes;
    List<dynamic>? productLinks;
    List<dynamic>? options;
    List<MediaGalleryEntry>? mediaGalleryEntries;
    List<dynamic>? tierPrices;
    List<CustomAttribute>? customAttributes;

    Item({
        this.id,
        this.sku,
        this.name,
        this.attributeSetId,
        this.price,
        this.status,
        this.visibility,
        this.typeId,
        this.createdAt,
        this.updatedAt,
        this.weight,
        this.extensionAttributes,
        this.productLinks,
        this.options,
        this.mediaGalleryEntries,
        this.tierPrices,
        this.customAttributes,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        sku: json["sku"],
        name: json["name"],
        attributeSetId: json["attribute_set_id"],
        price: json["price"]?.toDouble(),
        status: json["status"],
        visibility: json["visibility"],
        typeId: json["type_id"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        weight: json["weight"],
        extensionAttributes: json["extension_attributes"] != null ? ExtensionAttributes.fromJson(json["extension_attributes"]) : null,
        productLinks: json["product_links"] != null ? List<dynamic>.from(json["product_links"].map((x) => x)) : null,
        options: json["options"] != null ? List<dynamic>.from(json["options"].map((x) => x)) : null,
        mediaGalleryEntries: json["media_gallery_entries"] != null ? List<MediaGalleryEntry>.from(json["media_gallery_entries"].map((x) => MediaGalleryEntry.fromJson(x))) : null,
        tierPrices: json["tier_prices"] != null ? List<dynamic>.from(json["tier_prices"].map((x) => x)) : null,
        customAttributes: json["custom_attributes"] != null ? List<CustomAttribute>.from(json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "name": name,
        "attribute_set_id": attributeSetId,
        "price": price,
        "status": status,
        "visibility": visibility,
        "type_id": typeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "weight": weight,
        "extension_attributes": extensionAttributes?.toJson(),
        "product_links": productLinks != null ? List<dynamic>.from(productLinks!.map((x) => x)) : null,
        "options": options != null ? List<dynamic>.from(options!.map((x) => x)) : null,
        "media_gallery_entries": mediaGalleryEntries != null ? List<dynamic>.from(mediaGalleryEntries!.map((x) => x.toJson())) : null,
        "tier_prices": tierPrices != null ? List<dynamic>.from(tierPrices!.map((x) => x)) : null,
        "custom_attributes": customAttributes != null ? List<dynamic>.from(customAttributes!.map((x) => x.toJson())) : null,
    };
}

class CustomAttribute {
    String? attributeCode;
    dynamic value;

    CustomAttribute({
        this.attributeCode,
        this.value,
    });

    factory CustomAttribute.fromJson(Map<String, dynamic> json) => CustomAttribute(
        attributeCode: json["attribute_code"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "attribute_code": attributeCode,
        "value": value,
    };
}

class ExtensionAttributes {
    List<int>? websiteIds;
    List<CategoryLink>? categoryLinks;

    ExtensionAttributes({
        this.websiteIds,
        this.categoryLinks,
    });

    factory ExtensionAttributes.fromJson(Map<String, dynamic> json) => ExtensionAttributes(
        websiteIds: json["website_ids"] != null ? List<int>.from(json["website_ids"].map((x) => x)) : null,
        categoryLinks: json["category_links"] != null ? List<CategoryLink>.from(json["category_links"].map((x) => CategoryLink.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "website_ids": websiteIds != null ? List<dynamic>.from(websiteIds!.map((x) => x)) : null,
        "category_links": categoryLinks != null ? List<dynamic>.from(categoryLinks!.map((x) => x.toJson())) : null,
    };
}

class CategoryLink {
    int? position;
    String? categoryId;

    CategoryLink({
        this.position,
        this.categoryId,
    });

    factory CategoryLink.fromJson(Map<String, dynamic> json) => CategoryLink(
        position: json["position"],
        categoryId: json["category_id"],
    );

    Map<String, dynamic> toJson() => {
        "position": position,
        "category_id": categoryId,
    };
}

class MediaGalleryEntry {
    int? id;
    String? mediaType;
    String? label;
    int? position;
    bool? disabled;
    List<String>? types;
    String? file;

    MediaGalleryEntry({
        this.id,
        this.mediaType,
        this.label,
        this.position,
        this.disabled,
        this.types,
        this.file,
    });

    factory MediaGalleryEntry.fromJson(Map<String, dynamic> json) => MediaGalleryEntry(
        id: json["id"],
        mediaType: json["media_type"],
        label: json["label"],
        position: json["position"],
        disabled: json["disabled"],
        types: json["types"] != null ? List<String>.from(json["types"].map((x) => x)) : null,
        file: json["file"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "media_type": mediaType,
        "label": label,
        "position": position,
        "disabled": disabled,
        "types": types != null ? List<dynamic>.from(types!.map((x) => x)) : null,
        "file": file,
    };
}

class SearchCriteria {
    List<FilterGroup>? filterGroups;

    SearchCriteria({
        this.filterGroups,
    });

    factory SearchCriteria.fromJson(Map<String, dynamic> json) => SearchCriteria(
        filterGroups: json["filter_groups"] != null ? List<FilterGroup>.from(json["filter_groups"].map((x) => FilterGroup.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "filter_groups": filterGroups != null ? List<dynamic>.from(filterGroups!.map((x) => x.toJson())) : null,
    };
}

class FilterGroup {
    List<Filter>? filters;

    FilterGroup({
        this.filters,
    });

    factory FilterGroup.fromJson(Map<String, dynamic> json) => FilterGroup(
        filters: json["filters"] != null ? List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "filters": filters != null ? List<dynamic>.from(filters!.map((x) => x.toJson())) : null,
    };
}

class Filter {
    String? field;
    String? value;
    String? conditionType;

    Filter({
        this.field,
        this.value,
        this.conditionType,
    });

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        field: json["field"],
        value: json["value"],
        conditionType: json["condition_type"],
    );

    Map<String, dynamic> toJson() => {
        "field": field,
        "value": value,
        "condition_type": conditionType,
    };
}
