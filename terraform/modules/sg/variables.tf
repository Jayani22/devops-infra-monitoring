variable "name" {

}

variable "vpc_id" {
  
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string))
    source_sg   = optional(string)
  }))
}