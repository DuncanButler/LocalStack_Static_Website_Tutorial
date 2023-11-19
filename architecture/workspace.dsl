workspace {

    !docs "docs"

    model {
        user = person "User"
        website = softwareSystem "Static Website Application" {
            bucket = container "AWS S3 Bucket\nWWW Configuration" {
                tags = "Amazon Web Services - Simple Storage Service S3 Bucket"
            }
        }

        user -> Bucket "Static Pages Stored In S3 Bucket"
    }
        
    views {
        container website {
            include *
            autoLayout
        }
        
        theme https://static.structurizr.com/themes/amazon-web-services-2020.04.30/theme.json
    }
}