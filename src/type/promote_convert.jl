promote_rule(::Type{XFloat16}, ::Type{XFloat32}) = XFloat32

promote_rule(::Type{XFloat16}, ::Type{Float16} ) = XFloat16
promote_rule(::Type{XFloat16}, ::Type{Float32} ) = Float32
promote_rule(::Type{XFloat16}, ::Type{Float64} ) = Float64
promote_rule(::Type{XFloat16}, ::Type{BigFloat}) = BigFloat

promote_rule(::Type{XFloat32}, ::Type{Float16} ) = XFloat32
promote_rule(::Type{XFloat32}, ::Type{Float32} ) = XFloat32
promote_rule(::Type{XFloat32}, ::Type{Float64} ) = Float64
promote_rule(::Type{XFloat32}, ::Type{BigFloat}) = BigFloat

convert(::Type{XFloat16}, x::XFloat32) = reinterpret(XFloat16, Float32(reinterpret(Float64, x)))
convert(::Type{XFloat32}, x::XFloat16) = reinterpret(XFloat32, Float64(reinterpret(Float32, x)))

convert(::Type{XFloat16}, x::Float16)  = reinterpret(XFloat16, Float32(x))
convert(::Type{XFloat16}, x::Float32)  = reinterpret(XFloat16, x)
convert(::Type{XFloat16}, x::Float64)  = reinterpret(XFloat16, Float32(x))
convert(::Type{XFloat16}, x::BigFloat) = reinterpret(XFloat16, Float32(x))

convert(::Type{XFloat32}, x::Float16)  = reinterpret(XFloat32, Float64(x))
convert(::Type{XFloat32}, x::Float32)  = reinterpret(XFloat32, Float64(x))
convert(::Type{XFloat32}, x::Float64)  = reinterpret(XFloat32, x)
convert(::Type{XFloat32}, x::BigFloat) = reinterpret(XFloat32, Float64(x))

convert(::Type{Float16},  x::XFloat16) = Float16(reinterpret(Float32, x))
convert(::Type{Float32},  x::XFloat16) = reinterpret(Float32, x)
convert(::Type{Float64},  x::XFloat16) = Float64(reinterpret(Float32, x))
convert(::Type{BigFloat}, x::XFloat16) = BigFloat(reinterpret(Float32, x))

convert(::Type{Float16},  x::XFloat32) = Float16(reinterpret(Float64, x))
convert(::Type{Float32},  x::XFloat32) = Float32(reinterpret(Float64, x))
convert(::Type{Float64},  x::XFloat32) = reinterpret(Float64, x)
convert(::Type{BigFloat}, x::XFloat32) = BigFloat(reinterpret(Float64, x))

for T in (:Int8, :Int16, :Int32, :Int64, :Int128, :BigInt,
          :UInt8, :UInt16, :UInt32, :UInt64, :UInt128)
  @eval begin
    convert(::Type{XFloat16}, x::$T) = XFloat16(Float32(x))
    convert(::Type{XFloat32}, x::$T) = XFloat32(Float64(x))

    convert(::Type{$T}, x::XFloat16) = $T(reinterpret(Float32,x))
    convert(::Type{$T}, x::XFloat32) = $T(reinterpret(Float64,x))
  end
end
