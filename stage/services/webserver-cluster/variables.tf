# server port var
variable "server_port" {
  type        = number
  default     = 8080
  description = "store the http server port address"
}

# port var
variable "port_num" {
  type        = number
  default     = 80
  description = "http server port number"
}