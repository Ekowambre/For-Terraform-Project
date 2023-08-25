variable "region" {
  description = "VPC Region"
  default     = "eu-west-1"

}

variable "vpc_cidr" {
  description = "VPC cidr block"
  default     = "10.0.0.0/16"

}

variable "public_subnet_1_cidr" {
  description = "public subnet 1 cidr"
  default     = "10.0.5.0/24"

}

variable "tag-change" {
  description = "public subnet 1 cidr"
  default     = "Prod-pub-sub1"
}


variable "public_subnet_2_cidr" {
  description = "public subnet 2 cidr"
  default     = "10.0.6.0/24"

}

variable "private_subnet_1_cidr" {
  description = "private subnet 1 cider"
  default     = "10.0.7.0/24"

}
variable "private_subnet_2_cidr" {
  description = "private subnet 2 cider"
  default     = "10.0.8.0/24"

}

variable "instance-tenancy" {
  description = "instance tenancy"
  default     = "default"

}

variable "Tag-2" {
  description = "Tag-2"
  default     = "Tenacity-VPC"
}

variable "Tag-3" {
  description = "Tag-3"
  default     = "Prod-pub-sub2"
}

variable "Tag-4" {
  description = "Tag-4"
  default     = "Priv-pub-sub1"
}

variable "Tag-5" {
  description = "Tag-5"
  default     = "Priv-pub-sub2"
}


variable "Tag-6" {
  description = "Tag-6"
  default     = "Prod-pub-route-table"

}

variable "Tag-7" {
  description = "Tag-7"
  default     = "Prod-priv-route-table"

}
variable "Tag-8" {
  description = "Tag-8"
  default     = "Prod-igw"

}

variable "Tag-9" {
  description = "Tag-9"
  default     = "Prod-Nat-gateway"
}

variable "igw-destination-cidr" {
  description = "destination-cidr-for-igw"
  default     = "0.0.0.0/0"

}
variable "ngw-destination-cidr" {
  description = "destination-cidr-for-ngw"
  default     = "0.0.0.0/0"
}

variable "AZ-1" {
  description = "AZ-1"
  default     = "eu-west-1a"
}

variable "AZ-2" {
  description = "AZ-2"
  default     = "eu-west-1b"
}

variable "AZ-3" {
  description = "AZ-3"
  default     = "eu-west-1c"
}

variable "AZ-4" {
  description = "AZ-4"
  default     = "eu-west-1a"

}